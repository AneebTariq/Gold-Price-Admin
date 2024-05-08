import 'package:admin_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/response_models/user_data_model.dart';
import '../screens/auth_screens/otp_screen.dart';
import '../services/user_data.dart';
import '../utils/app_colors.dart';

class AuthController extends GetxController {
  RxBool isEnglish = true.obs;
  RxBool isUrdu = false.obs;
  TextEditingController pinPutController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final pinPutFocusNode = FocusNode();
  String otp = '';
  RxBool isOtp = false.obs;
  Rx<Color> buttonClr = AppColors.white.obs;
  Rx<Color> buttonTextClr = AppColors.primaryColor.obs;
  final _auth = FirebaseAuth.instance;
  RxBool isIdGet=false.obs;

  /// authentication functions
  Future<void> phoneAuthentication(String phoneNo) async {
    isIdGet.value=true;
    print("this is phoneNo:::$phoneNo");
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        isIdGet.value=false;
        print("this is accesToken:::$resendToken");
        print("this is verification id in auth :::$verificationId");
        Get.to(()=>OtpScreen(verifyId: verificationId,));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("this is verification id in auth timeout:::$verificationId");
        isIdGet.value=false;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
          isIdGet.value=false;
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again.');
          isIdGet.value=false;
        }
      },
    );
  }

  Future verifyOTP(String otp,String verifyId) async {
   try{
     isOtp.value=true;
     print("this is verification id :::$verifyId");
     var credentials = await _auth.signInWithCredential(
         PhoneAuthProvider.credential(
             verificationId: verifyId, smsCode: otp));
     print("otp response is this:::${credentials.user.toString()}");
     if( credentials.user != null ){
       final token=await FirebaseMessaging.instance.getToken();
       final sharedPrefs = await SharedPreferences.getInstance();
       UserPersistence userPersistence =  UserPersistence(sharedPrefs);
       userPersistence.save(UserPersistenceData(
         accessToken: token,
         uid: credentials.user!.uid??'',
         number:credentials.user!.phoneNumber??'',
       ));
       isOtp.value=false;
       Get.offAll(()=>const DasBoardScreen());
     }else{
       Get.snackbar('Wrong Otp', "Please Enter Correct Otp");
       isOtp.value=false;
       Get.back();
     }
   }catch(e,st){
     print('this is exception in verify otp::$e,$st');
     isOtp.value=false;
     Get.snackbar('Resend number', "The sms code has expired");
   }
  }


/// check login
  Future<bool> isLogin()async{
    final sharedPrefs = await SharedPreferences.getInstance();
    UserPersistence userPersistence =  UserPersistence(sharedPrefs);
    UserPersistenceData userData = userPersistence.load();
    print("this is login${userData.accessToken}");
    return userData.accessToken!=null&&userData.accessToken!.isNotEmpty?true:false;

  }

  void onChangeLanguage(var language){
    var local=Locale(language);
    Get.updateLocale(local);
  }

}
