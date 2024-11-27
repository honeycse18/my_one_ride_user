import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class CreateNewPasswordScreenController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;
  String token = '';
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onSavePasswordButtonTap() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (passwordTextEditingController.text.isEmpty ||
          passwordTextEditingController.text !=
              confirmPasswordTextEditingController.text) {
        APIHelper.onError(
            AppLanguageTranslation.eitherFieldTransKey.toCurrentLanguage);
        return;
      }
      createNewPass();
    } else {
      Get.snackbar(
        'Attention',
        'Please input correct format password',
        margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
        backgroundColor: AppColors.alertColor.withOpacity(0.4),
        colorText: Colors.black,
      );
    }
  }

  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != confirmPasswordTextEditingController.text) {
        return AppLanguageTranslation
            .mustMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != passwordTextEditingController.text) {
        return AppLanguageTranslation
            .notMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  Future<void> createNewPass() async {
    Map<String, dynamic> requestBody = {
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      'token': token
    };
    RawAPIResponse? response = await APIRepo.createNewPassword(requestBody);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation.noResponseFoundTransKey);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessChangingPassword(response);
  }

  onSuccessChangingPassword(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(
        messageText:
            AppLanguageTranslation.changePasswordTransKey.toCurrentLanguage);
    Get.offNamed(AppPageNames.logInScreen);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      token = params;
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }
}
