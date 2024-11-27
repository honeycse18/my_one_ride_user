import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_details_response.dart';
import 'package:one_ride_user/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class HireDriverDetailsScreenController extends GetxController {
  String hireDriverId = '';
  StreamSubscription<HireSocketResponse>? listener;
  HireDriverListItem hiredDriverDetails = HireDriverListItem.empty();
  RxDouble rate = 0.0.obs;
  void onAddTap() {
    rate.value++;
    update();
  }

  void onRemoveTap() {
    rate.value--;
    update();
  }

  Duration get isDays {
    return hiredDriverDetails.end.date
        .difference(hiredDriverDetails.start.date);
  }

  //------------post start method---------------
  Future<void> acceptRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      'status': 'accepted',
    };
    RawAPIResponse? response = await APIRepo.acceptRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessAcceptHireStatus(response);
  }

  _onSuccessAcceptHireStatus(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  //------------post start method---------------
  Future<void> updateRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      // 'status': 'accepted',
      'amount': rate.value,
    };
    RawAPIResponse? response = await APIRepo.updateRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessUpdateRequest(response);
  }

  _onSuccessUpdateRequest(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
    Get.back();
  }

  //------------post start method---------------
  Future<void> rejectRequest() async {
    Map<String, dynamic> requestBody = {
      '_id': hireDriverId,
      'status': 'cancelled',
    };
    RawAPIResponse? response = await APIRepo.rejectRequest(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessRejectRequest(response);
  }

  _onSuccessRejectRequest(RawAPIResponse response) async {
    await AppDialogs.showSuccessDialog(messageText: response.msg);
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
    rate.value = hiredDriverDetails.amount;
    update();
  }

  void _checkHireUpdate() {
    final SocketController socketController = Get.find<SocketController>();
    if (listener == null) {
      listener = socketController.hireDetails.listen((p0) {});
      listener?.onData((data) {
        if (data.driver.id == hireDriverId) {
          if (data.status == AppConstants.hireDriverListEnumStarted) {
            Get.offNamed(AppPageNames.hireDriverStartScreen,
                arguments: hireDriverId);
          }
        }
        update();
      });
    }
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
    _checkHireUpdate();
    super.onInit();
  }
}
