import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class ChangePasswordCreateController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  /// Toggle value of hide new password
  bool toggleHideOldPassword = true;
  bool toggleHideNewPassword = true;

  /// Toggle value of hide confirm password
  bool toggleHideConfirmPassword = true;

  /// Toggle value of over 5 characters requirement
  bool isPasswordOver8Characters = false;

  /// Toggle value of at least 1 digit number
  bool isPasswordHasAtLeastSingleNumberDigit = false;

  /// Create new password editing controller
  TextEditingController newPassword1EditingController = TextEditingController();
  TextEditingController currentPasswordEditingController =
      TextEditingController();
  TextEditingController newPassword2EditingController = TextEditingController();

  /// Password strong level value
  PasswordStrongLevel passwordStrongLevel = PasswordStrongLevel.none;

  /// Find if any password text character has number digit.
  bool detectPasswordNumber(String passwordText) =>
      passwordText.contains(RegExp(r'[0-9]'));
  String? passwordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword2EditingController.text) {
        return AppLanguageTranslation
            .mustMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  String? confirmPasswordFormValidator(String? text) {
    if (Helper.passwordFormValidator(text) == null) {
      if (text != newPassword1EditingController.text) {
        return AppLanguageTranslation
            .notMatchPasswordTransKey.toCurrentLanguage;
      }
      return null;
    }
    return Helper.passwordFormValidator(text);
  }

  /// Check password
  void passwordCheck(String passwordText) {
    setPasswordStrongLevel(passwordText);
    if (passwordText.length > 7) {
      isPasswordOver8Characters = true;
      if (detectPasswordNumber(passwordText)) {
        isPasswordHasAtLeastSingleNumberDigit = true;
      } else {
        isPasswordHasAtLeastSingleNumberDigit = false;
      }
    } else {
      isPasswordOver8Characters = false;
    }
  }

  /// Simple password strong level algorithm form new password field
  void setPasswordStrongLevel(String passwordText) {
    final isNumberFound = detectPasswordNumber(passwordText);
    if (passwordText.isEmpty) {
      passwordStrongLevel = PasswordStrongLevel.none;
    } else {
      if (passwordText.length > 5 && isNumberFound) {
        passwordStrongLevel = PasswordStrongLevel.strong;
        if (passwordText.length > 11 && isNumberFound) {
          passwordStrongLevel = PasswordStrongLevel.veryStrong;
        }
      } else if (passwordText.length > 5) {
        passwordStrongLevel = PasswordStrongLevel.normal;
      } else {
        passwordStrongLevel = PasswordStrongLevel.weak;
      }
    }
  }

  bool passMatched() {
    return newPassword1EditingController.text ==
        newPassword2EditingController.text;
  }

  void onSavePasswordButtonTap() {
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (passMatched()) {
        if (currentPasswordEditingController.text !=
            newPassword1EditingController.text) {
          sendPass();
        } else {
          APIHelper.onError(AppLanguageTranslation
              .youCanNotUseOldPassAsNewPassTransKey.toCurrentLanguage);
        }
      } else {
        APIHelper.onError(
            AppLanguageTranslation.notMatchPasswordTransKey.toCurrentLanguage);
      }
    } else {
      APIHelper.onError(AppLanguageTranslation
          .pleaseEnterValidFormPasswordTransKey.toCurrentLanguage);
    }
  }

  Future<void> sendPass() async {
    final Map<String, dynamic> requestBody = {
      'old_password': currentPasswordEditingController.text,
      'new_password': newPassword1EditingController.text,
      'confirm_password': newPassword2EditingController.text,
    };
    RawAPIResponse? response = await APIRepo.updatePassword(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    onSuccessSavePassword();
  }

  void onSuccessSavePassword() {
    BuildContext? context = Get.context;
    if (context != null) {
      Get.offNamed(AppPageNames.passwordChangedScreen);
    }
  }

  /*  void changePassword() {
    if (newPassword1EditingController.text.isEmpty ||
        currentPasswordEditingController.text.isEmpty) {
      AppDialogs.showErrorDialog(messageText: 'Fields can\'t be empty!');
      return;
    } else if (!passMatched()) {
      AppDialogs.showErrorDialog(messageText: 'Passwords don\'t match.');
      return;
    }
    // changePass();
  } */

  onSuccess() {
    Get.offNamed(AppPageNames.settingsScreen);
    AppDialogs.showSuccessDialog(
        messageText: AppLanguageTranslation
            .successfullyUpdatePasswordTransKey.toCurrentLanguage);
  }

  @override
  void onInit() {
    newPassword1EditingController = TextEditingController();
    newPassword1EditingController.addListener(() {
      passwordCheck(newPassword1EditingController.text);
      update();
    });

    super.onInit();
  }
}
