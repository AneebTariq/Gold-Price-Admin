import 'dart:io';
import 'package:admin_app/services/user_data.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response_models/user_data_model.dart';

class NotificationServices{
  
  FirebaseMessaging messaging= FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();



  void requestNotificationPermission()async{
    NotificationSettings settings=await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      print("user granted permission");
    }else if(settings.authorizationStatus==AuthorizationStatus.provisional){
      print("user granted provisional");
    }else{
      AppSettings.openAppSettings();
      print("user denied permission");
    }
  }

  void initNotifications(BuildContext context,RemoteMessage message)async{
    // var androidInitializationSettings=AndroidInitializationSettings('@drawable/ic_launcher');
    var androidInitializationSettings=const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings=const DarwinInitializationSettings();

    var initializationSetting =InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings
    );
    await _flutterLocalNotificationsPlugin.initialize(
        initializationSetting,
      onDidReceiveNotificationResponse: (payLoad){
        handleMessage(context, message);
      }
    );
  }

  /// function to show visible notification when app is active
  Future<void> showNotifications(RemoteMessage message)async{
/// for Android
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString() ,
        importance: Importance.max  ,
        showBadge: true ,
        playSound: true,
       // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        playSound: true,
        ticker: 'ticker' ,
        sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );
/// for IOS
    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true ,
        presentBadge: true ,
        presentSound: true
    ) ;

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails ,
      );
    });
    
  }
/// when app is terminated or background
  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }

  void handleMessage(BuildContext context, RemoteMessage message) {

    if(message.data['type'] =='msj'){
     // Get.to(() => NotificationScreen());
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {

      RemoteNotification? notification = message.notification ;
      AndroidNotification? android = message.notification!.android ;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if(Platform.isIOS){
        forgroundMessage();
      }

      if(Platform.isAndroid){
        initNotifications(context, message);
        showNotifications(message);
      }
    });
  }






  ///function to get device token on which we will send the notifications
  Future<String> getDeviceToken()async{
    String? token=await messaging.getToken();
    print('token :::');
    return token!;
  }
  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event)async {
      if(event !=null&&event.isNotEmpty){
        final sharedPrefs = await SharedPreferences.getInstance();
        UserPersistence userPersistence =  UserPersistence(sharedPrefs);
        userPersistence.save(UserPersistenceData(
          accessToken: event,
        ));
      }
      print('token refresh::: $event');
    });
  }
}