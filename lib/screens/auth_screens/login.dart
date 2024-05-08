import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/auth_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/helper.dart';
import '../../utils/image_assets.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.put(AuthController());
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(ImageAssets.loginBg,fit: BoxFit.cover,height: 870.h,),
            Positioned(
              top: 50.h,
              right: 20.w,
              child: Container(
                width: 144.w,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(()=> InkWell(
                        onTap:(){
                          authController.isEnglish.value=true;
                          authController.isUrdu.value=false;
                          authController.onChangeLanguage('en');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                          decoration: BoxDecoration(
                            color:authController.isEnglish.value?AppColors.primaryColor:AppColors.transparentColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(' English',style: AppTextStyles.font14_400TextStyle.copyWith(color:authController.isEnglish.value?AppColors.white:AppColors.black),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      ()=> InkWell(
                        onTap:(){
                          authController.isEnglish.value=false;
                          authController.isUrdu.value=true;
                          authController.onChangeLanguage('urdu');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                          decoration: BoxDecoration(
                            color: authController.isUrdu.value?AppColors.primaryColor:AppColors.transparentColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(' Urdu',style: AppTextStyles.font14_400TextStyle.copyWith(color:authController.isUrdu.value?AppColors.white:AppColors.black),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 4,
                      color: AppColors.white.withOpacity(0.1),
                    )
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('phone_number'.tr,style: AppTextStyles.font15_600TextStyle.copyWith(color: AppColors.primaryColor),),
                    SizedBox(height: 30.h,),
                    Container(
                      padding: EdgeInsets.only(left: 10.w,right: 10.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: authController.phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'enterNumber'.tr,
                          hintStyle: AppTextStyles.font14_400TextStyle.copyWith(color: AppColors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h,),
                    Obx(
                      ()=>authController.isIdGet.value
                          ?const Center(child: CircularProgressIndicator(),)
                          : CustomButton(
                        text: 'signUp'.tr,
                      buttonColor: AppColors.primaryColor,
                      onTap: (){
                       var phoneNumber= authController.phoneController.text.trim();
                       if (phoneNumber.length == 11) {
                         phoneNumber = phoneNumber.replaceAll(RegExp(r'^0+'), '');
                         print("this is my phone number::  +92$phoneNumber");
                        var number="+92$phoneNumber";
                         authController.phoneAuthentication(number);
                       } else {
                         print("Invalid phone number");
                         showToast('Please Enter valid number',);
                       }
                      },
                      ),
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
