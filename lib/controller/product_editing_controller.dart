import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../models/response_models/gold_live_price_model.dart';
import '../services/notification_services.dart';
import '../utils/helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductEditingController extends GetxController{


  TextEditingController arySellController=TextEditingController();
  TextEditingController aryBuyController=TextEditingController();
  /// tezabi
  TextEditingController tSellController=TextEditingController();
  TextEditingController tBuyController=TextEditingController();
  /// jewelry
  TextEditingController nameController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  TextEditingController crtController=TextEditingController();
  NotificationServices notificationServices = NotificationServices();
GoldLivePriceModel goldModel=GoldLivePriceModel();
  final goldPriceController = StreamController<GoldLivePriceModel>.broadcast();
  final notification=FirebaseDatabase.instance.ref('Notifications');
File? image;
List savedImages=[];
  UploadTask? uploadTask;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      getGoldPrice();
    });// Call the method to start fetching data
  }
/// gold price
  Future<void> getGoldPrice() async {
      try {
        final dio = Dio();
        final response = await dio.get('https://api.gold-api.com/price/XAU');
        goldModel = GoldLivePriceModel.fromJson(response.data);
        goldPriceController.sink.add(goldModel);
        notificationServices.isTokenRefresh();
      } catch (e, st) {
        print("Exception: $e, StackTrace: $st");
        goldPriceController.addError(e);
      }
  }
/// upload image on firebase storage
  Future uploadImages(File? image)async{
   if(image !=null){
     final path='${DateTime.now().millisecond}';
     final file=File(image.path);
     final ref=FirebaseStorage.instance.ref('jewelryImages/').child(path);
     uploadTask = ref.putFile(file);
     showLoadingDialog();
     final snapshot=await uploadTask!.whenComplete((){});
     final imageUrl=await snapshot.ref.getDownloadURL();
     print("this is picked ImageUrl::$imageUrl");
     savedImages.add(imageUrl);
     closeLoadingDialog();
   }else{
     Get.snackbar('Failed', 'Something went wrong');
   }
  }
/// select image from device
  Future<void> pickImage() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      print("this is image path${pickedImage.path}");
      image = File(pickedImage.path);
      print("pick images::::: $image");
      if (image != null) {
       uploadImages(image);
      }
    }  catch (e) {
      print('Failed to pick image: $e');
      closeLoadingDialog();
    }

  }
  Future<void> takeImage() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;
      print("this is image path${pickedImage.path}");
      image = File(pickedImage.path);
      print("take images::::: $image");
      if (image != null) {
        uploadImages(image);
      }
    }  catch (e) {
      print('Failed to pick image: $e');
      closeLoadingDialog();
    }
  }

  /// fetch jewelry data
  Future<void> fetchJewelryData() async {
    DatabaseReference jewelryRef = FirebaseDatabase.instance.reference().child('Jewelry');
    print('fetchJewelryData: 1');
    try {
      DataSnapshot snapshot = await jewelryRef.get();
      print('fetchJewelryData: 2');
      if (snapshot.value != null) {
        print('fetchJewelryData: 3');
        Map<dynamic, dynamic> jewelryData = snapshot.value as dynamic;
        // Iterate over each jewelry item
        print('fetchJewelryData: 4');
        jewelryData.forEach((key, value) {
          // Access individual properties like name, weight, and imageUrls
          String name = value['name'];
          String weight = value['weight'];
          List<String> imageUrls = List<String>.from(value['imageUrls']);
          // Do something with the fetched data, such as printing it
          print('Name: $name, Weight: $weight');
          print('Image URLs: $imageUrls');
        });
      } else {
        print('No jewelry data found');
      }
    } catch (e) {
      print('Failed to fetch jewelry data: $e');
    }
  }
/// delete data
  Future<void> deleteItem(String id) async {
    final jewelryRef=FirebaseDatabase.instance.ref('Jewelry');
    await jewelryRef.child(id).remove();
  }
/// send notification
  void sendNotifications(String? title, String? body)async {
    if (title == null || body == null) {
      print('Title, body, or type is null. Cannot send notification.');
      return;
    }
    // Constants
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    const String fcmAuthorizationKey = 'AAAAOZIPvEg:APA91bEJ0c7q4pEekFHaJgW3AlBPGk9dZgUkge4CFQoKErwe3cw_ND3G8QhCbJPGCls-6XqNidrwebYyyVt4IIE31xbClIz3_tHSZv6zMS1t77KbAVucxeC-lja9YzXdFJ3eobpEzmdK';
    // send notification from one device to all
      try {
        var data = {
          'to': '/topics/saadGold',
          'priority': 'high', // Removed space after 'priority'
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            'type': 'msj',
            'id': '1234'
          }
        };

        print('this is data: $data');

        final response = await http.post(
          Uri.parse(fcmUrl),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'key=$fcmAuthorizationKey',
          },
        );
        DateTime now = DateTime.now();
        // Format the time to get PM or AM string
        String amPm = DateFormat('a').format(now);
        String id=DateTime.now().minute.toString();
        notification.child(id).set(
            {'id':id,
              'title': title,
              'body': body,
              'date':'${DateFormat('h:mm:ss').format(now)} $amPm',
            }
        );

        if (kDebugMode) {
          print(response.body);
        }
      } catch (error) {
        print('Error occurred while sending notification: $error');
      }
  }






  @override
  void dispose() {
    // TODO: implement dispose
    aryBuyController.clear();
    arySellController.clear();
    tBuyController.clear();
    tSellController.clear();
    nameController.clear();
    weightController.clear();
    crtController.clear();
    super.dispose();
  }










}
