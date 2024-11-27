import 'package:get/get.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';

class SettingsScreenController extends GetxController {
  // RxBool isLoading = false.obs;
  RxBool toggleNotification = true.obs;
  String get currentLanguageText {
    final dynamic currentLanguageName =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    if (currentLanguageName is String) {
      return currentLanguageName;
    }
    return '';
  }
}
