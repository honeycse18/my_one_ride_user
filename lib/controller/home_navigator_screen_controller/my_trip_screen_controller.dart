import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:one_ride_user/models/api_responses/ride_history_response.dart';
import 'package:one_ride_user/models/api_responses/share_ride_history_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/models/screenParameters/accepted_request_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/choose_you_need_screen_parameter.dart';
import 'package:one_ride_user/models/screenParameters/select_car_screen_parameter.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class MyTripScreenController extends GetxController {
  RxBool isShareRideTabSelected = false.obs;

  Rx<RideHistoryStatus> selectedStatus = RideHistoryStatus.accepted.obs;
  Rx<ShareRideHistoryStatus> selectedShareRideStatus =
      ShareRideHistoryStatus.unknown.obs;
  Rx<ShareRideActions> selectedActionForRideShare =
      ShareRideActions.unknown.obs;
  Rx<ShareRideHistoryStatus> shareRideTypeTab =
      ShareRideHistoryStatus.findRide.obs;
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();

  PagingController<int, RideHistoryDoc> rideHistoryPagingController =
      PagingController(firstPageKey: 1);
  PagingController<int, ShareRideHistoryDoc> shareRideHistoryPagingController =
      PagingController(firstPageKey: 1);

  void onRideTabTap(RideHistoryStatus value) {
    selectedStatus.value = value;
    update();
    rideHistoryPagingController.refresh();
  }

  void onShareRideTabTap(ShareRideHistoryStatus value) {
    shareRideTypeTab.value = value;
    if (value == ShareRideHistoryStatus.findRide) {
      selectedActionForRideShare.value = ShareRideActions.myRequest;
      selectedShareRideStatus.value = ShareRideHistoryStatus.unknown;
    } else if (value == ShareRideHistoryStatus.offerRide) {
      selectedActionForRideShare.value = ShareRideActions.myOffer;
      selectedShareRideStatus.value = ShareRideHistoryStatus.unknown;
    } else {
      selectedActionForRideShare.value = ShareRideActions.unknown;
      selectedShareRideStatus.value = value;
    }
    update();
    log('Selected Action: ${selectedActionForRideShare.value.stringValueForView}\nSelected Tab: ${selectedShareRideStatus.value.stringValueForView}');
    shareRideHistoryPagingController.refresh();
  }

  onShareRideItemTap(String itemId, ShareRideHistoryDoc item, String type) {
    log('$itemId got tapped!');
    if (selectedActionForRideShare.value == ShareRideActions.myOffer) {
      Get.toNamed(AppPageNames.pullingOfferDetailsScreen,
          arguments: OfferOverViewScreenParameters(
              id: itemId, seat: item.seats, type: type));
    } else {
      if (item.offer.id.isEmpty) {
        Get.toNamed(AppPageNames.pullingOfferDetailsScreen, arguments: item.id);
      } else {
        log('$itemId Ride Got Tapped!');
        Get.toNamed(AppPageNames.pullingRequestDetailsScreen,
            arguments: itemId);
      }
    }
  }

  onRequestButtonTap(String requestId) async {
    log('$requestId got tapped!');
    await Get.toNamed(AppPageNames.viewRequestsScreen, arguments: requestId);
    shareRideHistoryPagingController.refresh();
  }

  void onRideWidgetTap(
    RideHistoryDoc ride,
  ) {
    log('${ride.id} got tapped');
    Get.toNamed(AppPageNames.acceptedRequestScreen,
        arguments: AcceptedRequestScreenParameter(
            rideId: ride.id,
            selectedCarScreenParameter: SelectCarScreenParameter(
                pickupLocation: LocationModel(
                    latitude: ride.from.location.lat,
                    longitude: ride.from.location.lng,
                    address: ride.from.address),
                dropLocation: LocationModel(
                    latitude: ride.to.location.lat,
                    longitude: ride.to.location.lng,
                    address: ride.to.address))));
  }

  Future<void> getRideHistory(currentPageNumber) async {
    RideHistoryResponse? response = await APIRepo.getRideHistory(
        page: currentPageNumber, filter: selectedStatus.value.stringValue);
    if (response == null) {
      log('No response for ride History!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessGettingHistory(response);
  }

  onSuccessGettingHistory(RideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      rideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    rideHistoryPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  Future<void> getShareRideHistory(currentPage) async {
    ShareRideHistoryResponse? response = await APIRepo.getShareRideHistory(
        page: currentPage,
        filter: selectedShareRideStatus.value.stringValue ==
                ShareRideHistoryStatus.unknown.stringValue
            ? ''
            : selectedShareRideStatus.value.stringValue,
        action: selectedActionForRideShare.value.stringValue ==
                ShareRideActions.unknown.stringValue
            ? ''
            : selectedActionForRideShare.value.stringValue);
    if (response == null) {
      log('No response for share Ride history list!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessFetchingHistory(response);
  }

  onSuccessFetchingHistory(ShareRideHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      shareRideHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    shareRideHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }

  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        shareRideHistoryPagingController.refresh();
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;
  @override
  void onInit() {
    rideHistoryPagingController.addPageRequestListener((pageKey) {
      getRideHistory(pageKey);
    });
    shareRideHistoryPagingController.addPageRequestListener((pageKey) {
      getShareRideHistory(pageKey);
    });
    SocketController socketController = Get.find<SocketController>();
    listen = socketController.pullingRequestResponseData.listen((p0) {});
    listen?.onData((data) {
      onNewPullingRequest(data);
    });
    listen2 = socketController.pullingRequestStatusResponseData.listen((p0) {});
    listen2?.onData((data) {
      onPullingRequestStatusUpdate(data);
    });

    super.onInit();
  }

  void popScope() {
    // listen?.cancel();
    // listen2?.cancel();
  }

  @override
  void onClose() {
    // listen?.cancel();
    // listen2?.cancel();
    super.onClose();
  }
}
