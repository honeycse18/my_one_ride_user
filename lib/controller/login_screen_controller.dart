import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:one_ride_user/models/api_responses/find_account_response.dart';
import 'package:one_ride_user/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class LogInScreenController extends GetxController {
  bool phoneMethod = false;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  void onContinueButtonTap() {
    findAccount();
  }

  Future<void> findAccount() async {
    String key = 'email';
    String value = emailTextEditingController.text;
    if (phoneMethod) {
      key = 'phone';
      value = getPhoneFormatted();
    }
    final Map<String, dynamic> requestBody = {
      key: value,
    };
    FindAccountResponse? response = await APIRepo.findAccount(requestBody);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFindingAccount(response);
  }

  onSuccessFindingAccount(FindAccountResponse response) {
    bool hasAccount = response.data.account;
    log(response.data.role);
    if (hasAccount) {
      Get.toNamed(AppPageNames.logInPasswordScreen,
          arguments: SignUpScreenParameter(
              isEmail: !phoneMethod,
              theValue: phoneMethod
                  ? getPhoneFormatted()
                  : emailTextEditingController.text));
      /* if (response.data.role == AppConstants.userRoleUser) {
       
      } else {
        APIHelper.onFailure(AppLanguageTranslation
            .alreadyHaveAccountTransKey.toCurrentLanguage);
        return;
      } */
    } else {
      Get.toNamed(AppPageNames.registrationScreen,
          arguments: SignUpScreenParameter(
              isEmail: !phoneMethod,
              countryCode: currentCountryCode,
              theValue: phoneMethod
                  ? phoneTextEditingController.text
                  : emailTextEditingController.text));
    }
  }

  void onMethodButtonTap() {
    phoneMethod = !phoneMethod;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // Helper.checkForUpdate();
    super.onInit();
  }

  @override
  void onClose() {
    // // TODO: implement onClose
    // emailTextEditingController.dispose();
    // phoneTextEditingController.dispose();
    super.onClose();
  }
}
