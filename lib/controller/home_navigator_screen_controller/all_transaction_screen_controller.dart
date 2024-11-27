import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_user/models/api_responses/withdraw_history_response.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';

class AllTransactionScreenScreenController extends GetxController {
  String symbol = '';
  RxBool isTransaction = true.obs;

  PagingController<int, TransactionHistoryItems>
      transactionHistoryPagingController = PagingController(firstPageKey: 1);
  PagingController<int, WalletWithdrawMethodItem>
      withdrawHistoryPagingController = PagingController(firstPageKey: 1);

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
    onSuccessGetTransactionList(response);
  }

  void onSuccessGetTransactionList(WalletTransactionHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      transactionHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    transactionHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  Future<void> getWithdrawRequestHistory(int currentPageNumber) async {
    WithdrawHistoryResponse? response =
        await APIRepo.getWithdrawRequestHistory(currentPageNumber);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetWithdrawRequestList(response);
  }

  void onSuccessGetWithdrawRequestList(WithdrawHistoryResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      withdrawHistoryPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    withdrawHistoryPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is String) {
      symbol = argument;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _getScreenParameters();
    transactionHistoryPagingController.addPageRequestListener((pageKey) {
      getTransactionHistory(pageKey);
    });
    withdrawHistoryPagingController.addPageRequestListener((pageKey) {
      getWithdrawRequestHistory(pageKey);
    });
    super.onInit();
  }
}
