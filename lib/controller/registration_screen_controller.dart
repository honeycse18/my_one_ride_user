import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/otp_request_response.dart';
import 'package:one_ride_user/models/screenParameters/sign_up_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class RegistrationScreenController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final RxBool isDropdownOpen = false.obs;
  final RxString selectedGender = 'Select Gender'.obs;
  SignUpScreenParameter? screenParameter;
  bool isEmail = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('BD');
  RxBool isCanOnTap = false.obs;
  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
    isDropdownOpen.value = false;
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
    // if (Helper.passwordFormValidator(text) == null) {
    if (text != passwordTextEditingController.text) {
      return AppLanguageTranslation.notMatchPasswordTransKey.toCurrentLanguage;
    }
    return null;
    // }
    // return Helper.passwordFormValidator(text);
  }

  /// Toggle value of hide password
  RxBool toggleHidePassword = true.obs;

  /// Toggle value of hide confirm password
  RxBool toggleHideConfirmPassword = true.obs;
  RxBool toggleAgreeTermsConditions = false.obs;

  void onPasswordSuffixEyeButtonTap() {
    toggleHidePassword.value = !toggleHidePassword.value;
  }

  void onConfirmPasswordSuffixEyeButtonTap() {
    toggleHideConfirmPassword.value = !toggleHideConfirmPassword.value;
  }

  void onToggleAgreeTermsConditions(bool? value) {
    toggleAgreeTermsConditions.value = value ?? false;
    update();
  }

  bool checkEmpty(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  void onContinueButtonInitialTap() {
    if (checkEmpty(nameTextEditingController) ||
        checkEmpty(emailTextEditingController) ||
        checkEmpty(phoneTextEditingController) ||
        checkEmpty(passwordTextEditingController) ||
        checkEmpty(confirmPasswordTextEditingController)) {
      APIHelper.onFailure('Please fill out all required fields first!');
      return;
    } else {
      onContinueButtonTap();
    }
  }

  void onContinueButtonTap() {
    if (checkEmpty(passwordTextEditingController) ||
        passwordTextEditingController.text !=
            confirmPasswordTextEditingController.text) {
      APIHelper.onFailure('Password and Confirm Password don\'t match!');
      return;
    }
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (!toggleAgreeTermsConditions.value) {
        APIHelper.onError(
            AppLanguageTranslation.mustAgreeRequestTransKey.toCurrentLanguage);
        return;
      }
      String key = 'phone';
      String value = getPhoneFormatted();
      if (isEmail) {
        key = 'email';
        value = emailTextEditingController.text;
      }
      Map<String, dynamic> requestBodyForOTP = {
        key: value,
        'action': 'registration',
      };
      requestForOTP(requestBodyForOTP);
    }
  }

  Future<void> requestForOTP(Map<String, dynamic> data) async {
    OtpRequestResponse? response = await APIRepo.requestOTP(data);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseOtpTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessSendingOTP(response);
  }

  String getPhoneFormatted() {
    return '${currentCountryCode.dialCode}${phoneTextEditingController.text}';
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    Map<String, dynamic> registrationData = {
      'name': nameTextEditingController.text,
      'phone': getPhoneFormatted(),
      'email': emailTextEditingController.text,
      'password': passwordTextEditingController.text,
      'confirm_password': confirmPasswordTextEditingController.text,
      'role': 'user',
      'isEmail': isEmail,
      'isForRegistration': true
    };
    Get.toNamed(AppPageNames.verificationScreen, arguments: registrationData);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is SignUpScreenParameter) {
      screenParameter = params;
      isEmail = screenParameter!.isEmail;
      if (screenParameter!.isEmail) {
        emailTextEditingController.text = screenParameter!.theValue;
      } else {
        phoneTextEditingController.text = screenParameter!.theValue;
        currentCountryCode =
            screenParameter!.countryCode ?? CountryCode.fromCountryCode('BD');
      }
    }
    update();
  }

  @override
  void onInit() {
    _getScreenParameters();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
