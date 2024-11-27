import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_details_response.dart';
import 'package:one_ride_user/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/submit_review_bottomSheet.dart';
import 'package:one_ride_user/utils/extensions/duration.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class HireDriverStartScreenController extends GetxController {
  String hireDriverId = '';
  Timer _timer = Timer(const Duration(), () {});
  Duration timeElapsedDuration = const Duration();
  HireDriverListItem hiredDriverDetails = HireDriverListItem.empty();

  Timer timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {});
  Duration duration = const Duration();

  /*  void _onTimerTick(Timer timer) {
    duration += const Duration(seconds: 1);
    Duration(seconds: hiredDriverDetails.time);
    update();
  } */
  void submitReview() {
    Get.bottomSheet(SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments: SubmitReviewScreenParameter(
                id: hireDriverId, type: 'driver_hire')));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      hiredDriverDetails.status == 'started'
          ? timeElapsedDuration += const Duration(seconds: 1)
          : timeElapsedDuration;
      update();
    });
  }

  Future<void> getHiredDriverDetails(String hireDriverId) async {
    final HireDriverDetailsResponse? response;
    response = await APIRepo.getHiredDriverDetails(hireDriverId: hireDriverId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessGetHiredDriverDetails(response);
  }

  _onSuccessGetHiredDriverDetails(HireDriverDetailsResponse response) {
    hiredDriverDetails = response.data;
    timeElapsedDuration = response.data.timeDuration;
    _startTimer();
    update();
  }

  String getElapsedTime() {
    String hours = timeElapsedDuration.toHumanReadableHoursText;
    String minutes = timeElapsedDuration.toHumanReadableMinutesText;
    String seconds = timeElapsedDuration.toHumanReadableSecondsText;
    return '$hours : $minutes : $seconds';
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      hireDriverId = argument;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    getHiredDriverDetails(hireDriverId);
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
