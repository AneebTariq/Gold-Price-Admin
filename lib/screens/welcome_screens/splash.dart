import 'package:admin_app/controller/auth_controller.dart';
import 'package:admin_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/image_assets.dart';
import '../auth_screens/login.dart';

class SplashScreen extends StatelessWidget {
 
  SplashScreen({Key? key}) : super(key: key);
AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Get Settings Data First If required
      authController.isLogin().then((value) async {
        if (value) {
           Get.offAll(() => const DasBoardScreen());
        } else {
      Get.offAll(() => LoginScreen());
       }
      });
   });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image:AssetImage(ImageAssets.splashBG),fit: BoxFit.cover ),
      ),
    );
  }
}
