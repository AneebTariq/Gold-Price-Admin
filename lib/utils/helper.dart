import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'app_colors.dart';

void showLoadingDialog(
    {Color? loaderColor, double? size, bool dismissible = false}) async {
  await Get.dialog(kLoadingWidget(loaderColor: loaderColor, size: size),
      barrierColor: AppColors.transparentColor,
      barrierDismissible: dismissible);
}

void closeLoadingDialog() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
  }
}

Widget kLoadingWidget({Color? loaderColor, double? size}) => Center(
      child: SpinKitFadingCube(
        color: loaderColor ?? AppColors.primaryColor,
        size: size ?? 30.0,
      ),
    );

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.lightGrey,
      textColor: AppColors.white,
      fontSize: 16);
}

showAlert(
    {required DialogType dialogType,
    required String title,
    String? description,
    VoidCallback? onCancelPress,
    VoidCallback? onOkPress,
    bool dismissOnTouchOutside = true,
    bool dismissOnBackKeyPress = true}) {
  AwesomeDialog(
    context: Get.context as BuildContext,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dialogType: dialogType,
    width: 400,
    animType: AnimType.bottomSlide,
    title: title,
    desc: description ?? "",
    btnCancelText: "dismiss".tr,
    btnCancelOnPress: onCancelPress ?? () {},
    btnOkOnPress: onOkPress,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
  ).show();
}
