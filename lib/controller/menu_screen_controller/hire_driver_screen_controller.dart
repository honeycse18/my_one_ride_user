import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_list_response.dart';
import 'package:one_ride_user/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class HireDriverScreenController extends GetxController {
  // Variables
  StreamSubscription<HireSocketResponse>? listener;
  Rx<RideDriverTabStatus> hireDriverStatusTab =
      RideDriverTabStatus.driverPending.obs;
  final PagingController<int, HireDriverListItem> hireDriverPagingController =
      PagingController(firstPageKey: 1);

  // Functions
  void onTabTap(RideDriverTabStatus value) {
    hireDriverStatusTab.value = value;
    hireDriverPagingController.refresh();
    update();
  }

  Future<void> getHireDriverList(int currentPageNumber) async {
    final String key = hireDriverStatusTab.value.stringValue;
    HireDriverListResponse? response =
        await APIRepo.getHireDriverList(page: currentPageNumber, key: key);
    if (response == null) {
      hireDriverPagingController.error = response;
      return;
    } else if (response.error) {
      hireDriverPagingController.error = response;
      return;
    }
    log((response.toJson().toString()));
    _onSuccessGetHireDriverList(response);
  }

  void _onSuccessGetHireDriverList(HireDriverListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      hireDriverPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    hireDriverPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  void _checkHireUpdate() {
    final SocketController socketController = Get.find<SocketController>();
    if (listener == null) {
      listener = socketController.hireDetails.listen((p0) {});
      listener?.onData((data) {
        hireDriverPagingController.refresh();
        update();
      });
    }
  }

  @override
  void onInit() {
    hireDriverPagingController.addPageRequestListener((pageKey) {
      getHireDriverList(pageKey);
    });
    _checkHireUpdate();
    super.onInit();
  }

  @override
  void onClose() {
    onDispose();
    super.onClose();
  }

  void onDispose() {}
}
