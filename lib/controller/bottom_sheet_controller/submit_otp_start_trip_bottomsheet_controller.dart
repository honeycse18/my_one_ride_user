import 'dart:developer';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class SubmitOtpStartRideBottomSheetController extends GetxController {
  // RideShareRequestSocketResponse rideShareRequestDetails =
  //     RideShareRequestSocketResponse.empty();
  bool isSuccess = false;
  ActionSliderController actionSliderController = ActionSliderController();
  PullingOfferDetailsRequest requestDetails =
      PullingOfferDetailsRequest.empty();

  TextEditingController otpTextEditingController = TextEditingController();
  String rideId = '';

  Future<void> acceptRejectRideRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': requestDetails.id,
      'status': 'started',
      'otp': otpTextEditingController.text,
    };
    RawAPIResponse? response =
        await APIRepo.startRideWithSubmitOtp(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    _onSuccessStartRideRequest(response);
  }

  _onSuccessStartRideRequest(RawAPIResponse response) async {
    isSuccess = true;
    Get.back(result: true);
    return;
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument is PullingOfferDetailsRequest) {
      requestDetails = argument;
      update();
    }
  }

  @override
  void onInit() {
    _getScreenParameter();
    super.onInit();
  }

  @override
  void dispose() {
    actionSliderController.dispose();
    otpTextEditingController.dispose();
    super.dispose();
  }
}
