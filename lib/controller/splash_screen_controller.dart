import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/language_translations_response.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class SplashScreenController extends GetxController {
  /* <---- Splash screen shows for 2 seconds and go to intro screen ----> */
  Future<void> delayAndGotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    // In case, the screen is not shown after 2 seconds, Do nothing.
    // Go to intro screen
    Get.offNamedUntil(_pageRouteName, (_) => false);
    // Get.toNamed(AppPageNames.introScreen);
  }

  String get _pageRouteName {
    final String pageRouteName;
    if (Helper.isUserLoggedIn()) {
      // if (Helper.isRememberedMe()) {
      pageRouteName = AppPageNames.homeNavigatorScreen;
      // } else {
      // pageRouteName = AppPageNames.logInScreen;
      // }
    } else {
      pageRouteName = AppPageNames.introScreen;
    }
    return pageRouteName;
  }

  static Future<void> getLanguageTranslations() async {
    LanguageTranslationsResponse? response =
        await APIRepo.fetchLanguageTranslations();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetLanguageTranslations(response);
  }

  static void _onSuccessGetLanguageTranslations(
      LanguageTranslationsResponse response) async {
    dynamic defaultLanguage =
        AppSingleton.instance.localBox.get(AppConstants.hiveDefaultLanguageKey);
    bool isDefaultLanguageSet = (defaultLanguage is String);
    for (LanguageTranslation languageTranslation in response.data) {
      languageTranslation.translation[AppConstants.languageTranslationKeyCode] =
          '${languageTranslation.code}_${languageTranslation.flag}';
      await AppSingleton.instance.localBox
          .put(languageTranslation.name, languageTranslation.translation);
      if (!isDefaultLanguageSet && languageTranslation.isDefault) {
        await AppSingleton.instance.localBox
            .put(AppConstants.hiveDefaultLanguageKey, languageTranslation.name);
      }
    }
  }

/* <---- Initial state ----> */
  @override
  void onInit() {
    Get.put(SocketController(), permanent: true);

    delayAndGotoNextScreen();
    // APIHelper.getSiteSettings();
    getLanguageTranslations();
    super.onInit();
  }
}
