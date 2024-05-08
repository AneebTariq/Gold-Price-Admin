import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../controller/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/image_assets.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
final String verifyId;
  final authController = Get.put(AuthController());


  OtpScreen({Key? key, required this.verifyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Image.asset(ImageAssets.loginBg,fit: BoxFit.cover,height: 870.h,),
            Padding(
              padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 300.h),
              child: Container(
                height: 300.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.black,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 4,
                        color: AppColors.white.withOpacity(0.1),
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    Pinput(
                      length: 6,
                      autofocus: true,
                      showCursor: true,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      validator: (String? pin){

                      },
                      onCompleted: (String pin) {
                        // _showSnackBar(pin);
                        authController.otp=pin;
                        if(authController.otp.length==4) {
                          authController.buttonClr.value = AppColors.primaryColor;
                          authController.buttonTextClr.value = AppColors.white;
                        }
                      } ,
                      focusNode: authController.pinPutFocusNode,
                      controller: authController.pinPutController,
                      //submittedFieldDecoration: pinPutDecoration,
                      pinAnimationType: PinAnimationType.scale,
                      cursor: Container(
                        height: 20.h,
                        width: 2.w,
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    Obx(
                      ()=>authController.isOtp.value
                          ?const Center(child: CircularProgressIndicator(),)
                          : CustomButton(
                        text: 'verifyOtp'.tr,
                        buttonColor: AppColors.primaryColor,
                        onTap: (){
                          authController.verifyOTP(authController.pinPutController.text.trim(),verifyId);
                        },
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Center(
                          child: Text(
                            'Resend OTP',
                            style: AppTextStyles.font15_600TextStyle.copyWith(color: AppColors.primaryColor),)),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
