import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/controller_binding.dart';
import 'locale/app_translation.dart';
import 'screens/welcome_screens/splash.dart';
import 'utils/constants.dart';
import 'utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(Constants.keyDbName);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();

  runApp(ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            locale: Get.deviceLocale,
            theme: ThemeData(
              textTheme: Typography.englishLike2018
                  .apply(fontSizeFactor: 1, bodyColor: AppColors.black),
              fontFamily: 'ProductSans',
              scaffoldBackgroundColor: AppColors.white,
              primaryColor: AppColors.primaryColor,
              backgroundColor: AppColors.white,
              indicatorColor: AppColors.primaryColor,
              hintColor: AppColors.hintColor,
              dividerColor: AppColors.dividerColor,
              cardColor: AppColors.white,
              tabBarTheme: TabBarTheme(
                unselectedLabelColor: AppColors.lightGrey,
                labelColor: AppColors.primaryColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppColors.primaryColor, width: 2.0),
                ),
              ),
            ),
            fallbackLocale: const Locale('en'),
            initialBinding: ControllersBinding(),
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => SplashScreen()),
            ]);
      }));
}
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}