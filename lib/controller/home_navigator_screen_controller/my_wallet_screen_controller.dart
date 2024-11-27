import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:one_ride_user/models/api_responses/get_wallet_details_response.dart';
import 'package:one_ride_user/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class MyWalletScreenScreenController extends GetxController {
  TextEditingController amountController = TextEditingController();
  WalletDetailsItem walletDetails = WalletDetailsItem.empty();
  PagingController<int, TransactionHistoryItems>
      transactionHistoryPagingController = PagingController(firstPageKey: 1);

  Future<void> getTransactionHistory(int currentPageNumber) async {
    WalletTransactionHistoryResponse? response =
        await APIRepo.getTransactionHistory(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(WalletTransactionHistoryResponse response) {
    // final isLastPage = !response.data.hasNextPage;
    // if (isLastPage) {
    transactionHistoryPagingController.appendLastPage(response.data.docs);
    return;
    // }
    /* final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(response.data.docs, nextPageNumber); */
  }

  Future<void> getWalletDetails() async {
    GetWalletDetailsResponse? response = await APIRepo.getWalletDetails();
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetWalletDetails(response);
  }

  void onSuccessGetWalletDetails(GetWalletDetailsResponse response) {
    walletDetails = response.data;
    update();
  }

  /* void updateFromHomeNavigator() {
    final homeNavController = Get.find<HomeNavigatorScreenController>();
    homeNavController;
  } */

  @override
  void onInit() {
    // TODO: implement onInit
    getWalletDetails();
    transactionHistoryPagingController.addPageRequestListener((pageKey) {
      getTransactionHistory(pageKey);
    });
    super.onInit();
  }
}
