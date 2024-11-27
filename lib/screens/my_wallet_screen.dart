import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/my_wallet_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/transaction_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/withdraw_dialog_widget.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyWalletScreenScreenController>(
        global: false,
        init: MyWalletScreenScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),
              body: SafeArea(
                child: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getWalletDetails();
                      controller.update();
                    },
                    child: Column(
                      children: [
                        AppGaps.hGap24,
                        /* Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFEF3E6)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                        AppAssetImages
                                            .dollerCountSVGLogoSolid),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(r'$500',
                                        style: AppTextStyles
                                            .titleSemiboldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryColor)),
                                    Text(
                                      'Available Balance',
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: Container(
                            height: 100,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(12, 0, 8, 0),
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFEFF6FF)),
                                  child: const Center(
                                    child: SvgPictureAssetWidget(
                                        AppAssetImages
                                            .dollerSendSVGLogoSolid),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(r'$500',
                                        style: AppTextStyles
                                            .titleSemiboldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryColor)),
                                    Text(
                                      'Total Expend',
                                      style: AppTextStyles.bodyTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ), */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: 134,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                                image: DecorationImage(
                                    image: Image.asset(
                                      AppAssetImages.walletBackImage,
                                    ).image,
                                    fit: BoxFit.fill),
                              ),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppGaps.hGap15,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .walletDetails.currency.symbol,
                                        style: AppTextStyles.titleBoldTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                      AppGaps.wGap6,
                                      Text(
                                        controller.walletDetails.balance
                                            .toStringAsFixed(2),
                                        style: AppTextStyles
                                            .titleLargeBoldTextStyle
                                            .copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  AppGaps.hGap10,
                                  Text(
                                    AppLanguageTranslation
                                        .yourWalletBalanceTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSmallSemiboldTextStyle
                                        .copyWith(color: Colors.white),
                                  ),
                                  AppGaps.hGap24,
                                  /* Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        height: 1,
                                        color: Colors.white,
                                      ))
                                    ],
                                  ), */
                                  /* AppGaps.hGap18,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          const SvgPictureAssetWidget(
                                            AppAssetImages.repeatSVGLogoLine,
                                            color: Colors.white,
                                          ),
                                          AppGaps.wGap8,
                                          Text(
                                            AppLanguageTranslation
                                                .todayEarningTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .bodyBoldTextStyle
                                                .copyWith(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      AppGaps.wGap20,
                                      Text(
                                        r'$500.36',
                                        style: AppTextStyles
                                            .bodySemiboldTextStyle
                                            .copyWith(color: Colors.white),
                                      )
                                    ],
                                  ), */
                                ],
                              )),
                            ))
                          ],
                        ),
                        AppGaps.hGap12,
                        Row(
                          children: [
                            Expanded(
                              child: CustomStretchedOutlinedButtonWidget(
                                child: Text(
                                  AppLanguageTranslation
                                      .withdrawTransKey.toCurrentLanguage,
                                  style: const TextStyle(
                                      color: AppColors.primaryColor),
                                ),
                                onTap: () {
                                  Get.dialog(WithdrawDialogWidget());
                                  /* showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WithdrawDialogWidget();
                                    },
                                  ); */
                                },
                              ),
                            ),
                            AppGaps.wGap15,
                            Expanded(
                              child: CustomStretchedTextButtonWidget(
                                buttonText: AppLanguageTranslation
                                    .topUpTransKey.toCurrentLanguage,
                                onTap: () async {
                                  await Get.toNamed(AppPageNames.topupScreen);
                                  controller.getWalletDetails();
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        AppGaps.hGap24,
                        AppGaps.hGap24,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .transactionTransKey.toCurrentLanguage,
                              style:
                                  AppTextStyles.titleSemiSmallSemiboldTextStyle,
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(AppPageNames.allTransactionScreen,
                                      arguments: controller
                                          .walletDetails.currency.symbol);
                                },
                                child: Text(
                                  AppLanguageTranslation
                                      .seeAllTransKey.toCurrentLanguage,
                                  style: AppTextStyles.bodyTextStyle
                                      .copyWith(color: AppColors.primaryColor),
                                ))
                          ],
                        ),
                        AppGaps.hGap15,
                        Expanded(
                            child: RefreshIndicator(
                          onRefresh: () async => controller
                              .transactionHistoryPagingController
                              .refresh(),
                          child: CustomScrollView(
                            slivers: [
                              PagedSliverList.separated(
                                pagingController: controller
                                    .transactionHistoryPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        TransactionHistoryItems>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    symbol: controller
                                        .walletDetails.currency.symbol,
                                    isEarned: transactionHistoryList.type ==
                                            'add_money'
                                        ? true
                                        : false,
                                    amount: transactionHistoryList.amount,
                                    date: transactionHistoryList.createdAt,
                                    time: transactionHistoryList.createdAt,
                                    transactionName:
                                        transactionHistoryList.type,
                                    transactionType:
                                        transactionHistoryList.method,
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              ),
                              SliverToBoxAdapter(
                                child: AppGaps.hGap50,
                              )
                            ],
                          ),
                        )

                            /* ListView.separated(
                              padding: EdgeInsets.only(bottom: 35),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                /* return TransactionWidget(
                                  isEarned: false,
                                  amount: 16.0,
                                  date: DateTime.now(),
                                  time: DateTime.now(),
                                  transactionName: 'TopUp Tomney',
                                  transactionType: 'Expendad',
                                ); */
                              },
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                              itemCount: 20), */
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
