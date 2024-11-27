import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/rent_details_response.dart';
import 'package:one_ride_user/models/screenParameters/submit_review_screen_parameter.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/submit_review_bottomSheet.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class CarRentListDetailsScreenController extends GetxController {
  RentDetailsItem rentCarListDetails = RentDetailsItem.empty();
  String carRentId = '';

  void submitReview() async {
    await Get.bottomSheet(SubmitReviewBottomSheetScreen(),
        settings: RouteSettings(
            arguments:
                SubmitReviewScreenParameter(id: carRentId, type: 'rent')));
  }

  Future<void> getRentDetails() async {
    RentDetailsResponse? response = await APIRepo.getRentDetails(id: carRentId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetRentDetails(response);
  }

  _onSuccessGetRentDetails(RentDetailsResponse response) {
    rentCarListDetails = response.data;
    update();
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      carRentId = params;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    getRentDetails();
    super.onInit();
  }
}
