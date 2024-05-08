import 'package:get/get.dart';
import 'common_controller.dart';

class ControllersBinding extends Bindings {
  void dependencies() {
    Get.put(CommonController(), permanent: true);
    // Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
  }
}
