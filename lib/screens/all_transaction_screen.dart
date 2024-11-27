import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/all_transaction_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_user/models/api_responses/withdraw_history_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/transaction_widget.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllTransactionScreenScreenController>(
        global: false,
        init: AllTransactionScreenScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .allTransactionTransKey.toCurrentLanguage),
              ),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async => controller.isTransaction.value
                    ? controller.transactionHistoryPagingController.refresh()
                    : controller.withdrawHistoryPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap10,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 82,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(22))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CustomTabToggleButtonWidget(
                                        text: 'Transaction',
                                        isSelected:
                                            controller.isTransaction.value,
                                        onTap: () => controller
                                            .isTransaction.value = true,
                                      ))),
                            ),
                            AppGaps.wGap5,
                            Obx(() => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomTabToggleButtonWidget(
                                        text: 'Withdraw',
                                        isSelected:
                                            !controller.isTransaction.value,
                                        onTap: () {
                                          controller.isTransaction.value =
                                              false;
                                        }),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap20,
                    ),
                    Obx(() => controller.isTransaction.value
                        ? PagedSliverList.separated(
                            pagingController:
                                controller.transactionHistoryPagingController,
                            builderDelegate: PagedChildBuilderDelegate<
                                    TransactionHistoryItems>(
                                noItemsFoundIndicatorBuilder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                      //-----------------------
                                      localImageAssetURL:
                                          AppAssetImages.confirmIconImage,
                                      title: AppLanguageTranslation
                                          .noTransactionTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final TransactionHistoryItems
                                  transactionHistoryList = item;
                              return TransactionWidget(
                                symbol: controller.symbol,
                                isEarned:
                                    transactionHistoryList.type == 'add_money'
                                        ? true
                                        : false,
                                amount: transactionHistoryList.amount,
                                date: transactionHistoryList.createdAt,
                                time: transactionHistoryList.createdAt,
                                transactionName: transactionHistoryList.type,
                                transactionType: transactionHistoryList.method,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          )
                        : PagedSliverList.separated(
                            pagingController:
                                controller.withdrawHistoryPagingController,
                            builderDelegate: PagedChildBuilderDelegate<
                                    WalletWithdrawMethodItem>(
                                noItemsFoundIndicatorBuilder: (context) {
                              return const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EmptyScreenWidget(
                                      //-----------------------
                                      localImageAssetURL:
                                          AppAssetImages.confirmIconImage,
                                      title: 'No Withdraw History',
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final WalletWithdrawMethodItem
                                  withdrawMethodHistoryList = item;
                              return WithdrawTransactionWidget(
                                symbol: controller.symbol,
                                isEarned: false,
                                amount: withdrawMethodHistoryList.amount,
                                date: withdrawMethodHistoryList.createdAt,
                                time: withdrawMethodHistoryList.createdAt,
                                transactionName: withdrawMethodHistoryList
                                    .withdrawMethod.type,
                                transactionType:
                                    withdrawMethodHistoryList.status,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          )),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap30,
                    ),
                  ],
                ),
              )),
            ));
  }
}
