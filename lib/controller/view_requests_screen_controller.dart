import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class ViewRequestsScreenController extends GetxController {
  String test = 'View Requests Screen Controller is connected!';
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();

  String requestId = '';
  String type = 'vehicle';
  PullingOfferDetailsData requestDetails = PullingOfferDetailsData.empty();
  List<PullingOfferDetailsRequest> pendingRequests = [];

  Future<void> getRequestDetails() async {
    PullingOfferDetailsResponse? response =
        await APIRepo.getPullingOfferDetails(requestId);
    if (response == null) {
      APIHelper.onError(AppLanguageTranslation
          .noResponseFoundRideDetailsTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRetrievingRequestDetails(response);
  }

  onSuccessRetrievingRequestDetails(PullingOfferDetailsResponse response) {
    requestDetails = response.data;
    pendingRequests = response.data.pending;
    update();
  }

  void onAcceptButtonTap(String requestId) {
    log('Accepted');
    acceptTheRequest(requestId);
  }

  void onRejectButtonTap(String requestId) {
    log('Rejected');
    rejectTheRequest(requestId);
  }

  Future<void> acceptTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'accepted');
    if (response == null) {
      log('No response for accepting request!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessAcceptingRequest(response);
  }

  onSuccessAcceptingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  Future<void> rejectTheRequest(String requestId) async {
    RawAPIResponse? response = await APIRepo.updateShareRideRequest(
        requestId: requestId, action: 'reject');
    if (response == null) {
      log('No response for rejecting request!');
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    onSuccessRejectingRequest(response);
  }

  onSuccessRejectingRequest(RawAPIResponse response) {
    getRequestDetails();
    update();
    AppDialogs.showSuccessDialog(messageText: response.msg);
  }

  _getScreenParameters() {
    dynamic params = Get.arguments;
    if (params is String) {
      requestId = params;
      update();
      if (requestId.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        getRequestDetails();
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  @override
  void onInit() {
    _getScreenParameters();
    SocketController socketController = Get.find<SocketController>();

    listen = socketController.pullingRequestResponseData.listen((p0) {
      onNewPullingRequest(p0);
    });
    super.onInit();
  }

  void popScope() {
    listen?.cancel();
  }

  @override
  void onClose() {
    listen?.cancel();
    super.onClose();
  }
}
