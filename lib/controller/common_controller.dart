import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/login_data_model.dart';
import '../screens/auth_screens/login.dart';
import '../utils/constants.dart';


class CommonController extends GetxController {
  var isDarkTheme = false.obs;
  var selectedLanguage = "en".obs;
  final localStorage = GetStorage(Constants.keyDbName);
  var user = LoginModel();
  @override
  void onInit() {
    super.onInit();
    getThemeFromStorage();
  }

  Future<void> setFirstTimeOver() async {
    await localStorage.write(Constants.keyIsFirstTime, true);
  }

  Future<void> getThemeFromStorage() async {
    var res = await localStorage.read(Constants.keyIsDarkTheme);
    if (res != null) {
      isDarkTheme.value = res;
      return;
    }
    isDarkTheme.value = false;
  }

  Future<void> setDarkTheme({required bool enableDarkTheme}) async {
    await localStorage.write(Constants.keyIsDarkTheme, enableDarkTheme);
    isDarkTheme.value = enableDarkTheme;
  }


  logOutUser() async {
    await localStorage.remove(Constants.keyUser);
    Get.offAll(LoginScreen());
  }

  
}
