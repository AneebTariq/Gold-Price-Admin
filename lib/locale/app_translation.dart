import 'package:admin_app/locale/urdu.dart';
import 'package:get/get.dart';
import 'english.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': english(),
        'urdu':urdu(),
      };
}
