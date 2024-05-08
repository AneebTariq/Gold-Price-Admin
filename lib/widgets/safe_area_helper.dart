import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/common_controller.dart';
import '../utils/app_colors.dart';

class SafeAreaHelper extends StatelessWidget {
  final Widget child;
  final dynamic backgroundColor;
  final dynamic statusBarColor;
  final dynamic statusBarIconBrightness;
  final CommonController controller = Get.find<CommonController>();
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;

  SafeAreaHelper({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.appBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: (statusBarColor is Color)
              ? statusBarColor
              : controller.isDarkTheme.value
                  ? AppColors.black
                  : AppColors.white,
          statusBarIconBrightness: (statusBarIconBrightness is Brightness)
              ? statusBarIconBrightness
              : controller.isDarkTheme.value
                  ? Brightness.light
                  : Brightness.dark,
        ),
        child: Container(
          color: (statusBarColor is Color)
              ? statusBarColor
              : controller.isDarkTheme.value
                  ? AppColors.black
                  : AppColors.white,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: (backgroundColor is Color)
                  ? backgroundColor
                  : controller.isDarkTheme.value
                      ? AppColors.black
                      : AppColors.white,
              appBar: appBar,
              body: child,
              floatingActionButton: floatingActionButton,
            ),
          ),
        ),
      ),
    );
  }
}
