import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:one_ride_user/models/api_responses/otp_request_response.dart';
import 'package:one_ride_user/models/api_responses/otp_verification_response.dart';
import 'package:one_ride_user/models/api_responses/registration_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_local_stored_keys.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class VerificationScreenController extends GetxController {
  TextEditingController otpInputTextController = TextEditingController();
  Map<String, dynamic> theData = {};
  Map<String, dynamic> resendCodeForgotPass = {};
  bool isEmail = true;
  bool isForRegistration = true;

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  /// OTP timer duration value
  Duration otpTimerDuration = const Duration();

  /// OTP timer
  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );

  // OTPScreenParameter otpScreenParameter = OTPScreenParameter();

  _resetTimer() {
    otpTimerDuration = const Duration(seconds: 120);
  }

  onSendCodeButtonTap() {
    sendCode();
  }

  void onResendButtonTap() {
    if (isDurationOver()) {
      resendCode();
    } else {
      APIHelper.onError('Please wait few more seconds');
    }
  }

  Future<void> sendCode() async {
    theData['otp'] = otpInputTextController.text;
    if (isForRegistration) {
      /* final Map<String, Object> requestBody = {
        'user_input': otpScreenParameter.userInput,
        'otp': otpInputTextController.text,
      }; */
      /* if (isEmail) {
        theData.remove('phone');
      } */
      // String requestBodyJson = jsonEncode(requestBody);
      RegistrationResponse? response = await APIRepo.registration(theData);
      if (response == null) {
        APIHelper.onError('No response for this action!');
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessResponse(response);
    } else {
      /* final Map<String, Object> requestBody = {
        'phone': otpScreenParameter.userInput,
        'otp': otpInputTextController.text
      };
      */
      OtpVerificationResponse? response = await APIRepo.verifyOTP(theData);
      if (response == null) {
        APIHelper.onError('No response for this action!');
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessGettingOtpVerified(response);
      /*
      String requestBodyJson = jsonEncode(requestBody);
      SignUpOtpVerificationResponse? response =
          await APIRepo.signUpOtpVerification(requestBodyJson);
      if (response == null) {
        onErrorResponseOfVendorVerify(response);
        return;
      } else if (response.error) {
        onFailureResponseVendorVerify(response);
        return;
      }
      log(response.toJson().toString());
      onSuccessResponseOfVendorVerify(response); */
    }
  }

  onSuccessGettingOtpVerified(OtpVerificationResponse response) {
    Get.offNamed(AppPageNames.createNewPasswordScreen,
        arguments: response.data.token);
  }

  Future<void> resendCode() async {
    if (isForRegistration) {
      String key = 'phone';
      String value = theData['phone'];
      if (isEmail) {
        key = 'email';
        value = theData['email'];
      }
      final Map<String, dynamic> requestBody = {
        key: value,
        'action': 'registration',
      };
      // String requestBodyJson = jsonEncode(requestBody);
      OtpRequestResponse? response = await APIRepo.requestOTP(requestBody);
      if (response == null) {
        APIHelper.onError('No response for resending Code!');
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessResendCode();
    } else {
      OtpRequestResponse? response =
          await APIRepo.requestOTP(resendCodeForgotPass);
      if (response == null) {
        APIHelper.onError('No response for this operation!');
        return;
      } else if (response.error) {
        APIHelper.onFailure(response.msg);
        return;
      }
      log(response.toJson().toString());
      onSuccessSendingOTP(response);
      /*   final Map<String, Object> requestBody = {
        'phone': otpScreenParameter.userInput
      };
      String requestBodyJson = jsonEncode(requestBody);
      SendOtpResponse? response =
          await APIRepo.sendVerifyUserOTP(requestBodyJson);
      if (response == null) {
        onErrorResendOTP(response);
        return;
      } else if (response.error) {
        onFailureResendOTP(response);
        return;
      }
      log(response.toJson().toString());
      onSuccessResendCode(); */
    }
  }

  onSuccessSendingOTP(OtpRequestResponse response) {
    AppDialogs.showSuccessDialog(messageText: 'Code has been resent!');
    _resetTimer();
  }

  // For resending otp for Reset Password
  void onSuccessResendCode() {
    AppDialogs.showSuccessDialog(messageText: 'Code has been resent!');
    _resetTimer();
  }

/*
  void onErrorResponse(OtpVerifyResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResponse(OtpVerifyResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }
*/
  void onSuccessResponse(RegistrationResponse response) {
    fetchUserDetails(response.data.token);
    // Get.offNamed(AppPageNames.homeNavigatorScreen,
    //     arguments: response.data.token);
  }

  Future<void> fetchUserDetails(String token) async {
    await GetStorage().write(LocalStoredKeyName.loggedInUserToken, token);
    getLoggedInUserDetails(token);
    // UserDetailsResponse? response = await APIRepo.getUser(token);
  }

  Future<void> getLoggedInUserDetails(String token) async {
    UserDetailsResponse? response = await APIRepo.getUserDetails(token: token);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noResponseFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInUserDetails(response);
  }

  void onSuccessGetLoggedInUserDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    Get.offAllNamed(AppPageNames.homeNavigatorScreen);
  }

/*
// For SignUp page OTP
  void onErrorResendOTP(SendOtpResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResendOTP(SendOtpResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  // From sign in page
  void onErrorResponseOfVendorVerify(SignUpOtpVerificationResponse? response) {
    AppDialogs.showErrorDialog(messageText: response?.msg ?? '');
  }

  void onFailureResponseVendorVerify(SignUpOtpVerificationResponse response) {
    AppDialogs.showErrorDialog(messageText: response.msg);
  }

  void onSuccessResponseOfVendorVerify(RegistrationResponse response) {
    if (otpScreenParameter.isFromResetPassPage) {
      Get.offNamed(AppPageNames.signInScreen);
    } else {
      Get.offNamed(AppPageNames.setupDeliveryManInfoScreen,
          arguments: response.token);
    }
  }

  bool isDurationOver() {
    return otpTimerDuration.inSeconds <= 0;
  }

  /// OTP timer duration value
  Duration otpTimerDuration = const Duration();

  /// OTP timer
  Timer otpTimer = Timer(
    const Duration(seconds: 1),
    () {},
  );

*/
  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is Map<String, dynamic>) {
      theData = argument;
      isEmail = theData['isEmail'];
      isForRegistration = theData['isForRegistration'];
      theData.remove('isEmail');
      theData.remove('isForRegistration');
    }
    update();
    if (!isForRegistration) {
      resendCodeForgotPass = theData['resendCode'];
      theData.remove('resendCode');
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    otpTimerDuration = const Duration(seconds: 120);
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimerDuration.inSeconds > 0) {
        otpTimerDuration = otpTimerDuration - const Duration(seconds: 1);
      }
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    if (otpTimer.isActive) {
      otpTimer.cancel();
    }
    super.dispose();
  }
}
