class ApiServices{
  //create instance of model,
  //make api cell in given function,
  Future userLogin()async{
//  try {
//       showLoadingDialog();
//       var response = await BaseClient().post(
//         Constants.loginUrl,
//         '{"email":"${email.trim()}","password":"${password.trim()}"}',
//       );
//       print("response is ${response}");
//       if (response != null) {
//         var data = LoginModel.fromJson(response['data']);
//         print("response is not null${data.token}");
//         if (data.token != null) {
//           print("data.token is not null");
//           return data;
//           bool res = await saveCredentials(data);
//           if (res) {
//             print("res is true");
//             showToast("Login Success");
//             gotoDashboardScreen();
//           } else {
//             showAlert(
//                 dialogType: DialogType.error,
//                 title: "errorOccurred".tr,
//                 description: "tokenSavingFailed".tr);
//           }
//         } else {
//           showAlert(
//               dialogType: DialogType.error,
//               title: "errorOccurred".tr,
//               description: "tokenNotAvailable".tr);
//         }
//       }
//     } catch (e, stacktrace) {
//       closeLoadingDialog();
//       if (kDebugMode) {
//         print("ERROR: $e" + "$stacktrace");
//       }
//       showAlert(
//           dialogType: DialogType.error,
//           title: "exceptionOccurred".tr,
//           description: e.toString());
//     }
  }



}