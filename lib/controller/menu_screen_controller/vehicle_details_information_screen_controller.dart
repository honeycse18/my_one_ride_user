import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/car_rent_details_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class VehicleDetailsInfoScreenController extends GetxController {
  String vehicleId = '';
  Rx<CarDetailsInfoTypeStatus> vehicleInfoStatusTab =
      CarDetailsInfoTypeStatus.specifications.obs;

  CarRentItem carRentDetails = CarRentItem.empty();

  final PageController imageController = PageController(keepPage: false);
  final PageController documentController = PageController(keepPage: false);
  List<String> images = [];
  List<String> documents = [];

  Future<void> getVehicleDetails(String productId) async {
    CarRentDetailsResponse? response =
        await APIRepo.getVehicleDetails(id: productId);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetVehicleDetailsResponse(response);
  }

  _onSuccessGetVehicleDetailsResponse(CarRentDetailsResponse response) {
    carRentDetails = response.data;
    update();
  }

  void onTabTap(CarDetailsInfoTypeStatus value) {
    vehicleInfoStatusTab.value = value;
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      vehicleId = argument;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    getVehicleDetails(vehicleId);

    super.onInit();
  }
}
