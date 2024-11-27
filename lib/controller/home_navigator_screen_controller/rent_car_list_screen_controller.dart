import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/car_rent_response.dart';
import 'package:one_ride_user/models/api_responses/new_rent_socket_response.dart';
import 'package:one_ride_user/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class RentCarListScreenController extends GetxController {
  Rx<RideHistoryStatus> rideTypeTab = RideHistoryStatus.accepted.obs;
  RentStatusSocketResponse rentStatusUpdate = RentStatusSocketResponse.empty();

  TextEditingController messageTextEditingController = TextEditingController();

  void onRideTabTap(RideHistoryStatus value) {
    rideTypeTab.value = value;
    rideTripPagingController.refresh();
    update();
  }

  PagingController<int, CarRentListItem> rideTripPagingController =
      PagingController(firstPageKey: 1);

  Future<void> getRentCarList(int currentPageNumber) async {
    final String key = rideTypeTab.value.stringValue;
    CarRentListResponse? response =
        await APIRepo.getRentCarList(page: currentPageNumber, key: key);
    if (response == null) {
      onErrorGetHireDriverList(response);
      return;
    } else if (response.error) {
      onFailureGetHireDriverList(response);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetHireDriverList(response);
  }

  void onErrorGetHireDriverList(CarRentListResponse? response) {
    rideTripPagingController.error = response;
  }

  void onFailureGetHireDriverList(CarRentListResponse response) {
    rideTripPagingController.error = response;
  }

  void onSuccessGetHireDriverList(CarRentListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideTripPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideTripPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  dynamic onRentStatusUpdate(dynamic data) {
    if (data is RentStatusSocketResponse) {
      rentStatusUpdate = data;
      update();
      if (rentStatusUpdate.id.isNotEmpty) {
        rideTripPagingController.refresh();
      }
    }
  }

  late StreamSubscription<NewRentSocketResponse> listen;
  late StreamSubscription<RentStatusSocketResponse> listen2;

  @override
  void onInit() {
    // TODO: implement onInit
    rideTripPagingController.addPageRequestListener((pageKey) {
      getRentCarList(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen2 = socketController.rentStatusSocketData.listen((p0) {
      onRentStatusUpdate(p0);
    });
    super.onInit();
  }

  @override
  void onClose() {
    listen2.cancel();
    messageTextEditingController.dispose();
    super.onClose();
  }
}
