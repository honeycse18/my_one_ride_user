import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/topup_screen_controller.dart';
import 'package:one_ride_user/models/fakeModel/fake_data.dart';
import 'package:one_ride_user/models/fakeModel/payment_option_model.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/payment_screen_widget.dart';

class TopupScreen extends StatelessWidget {
  const TopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopupScreenController>(
        global: false,
        init: TopupScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: const Color(0xFFF7F7FB),
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.screenTitle)),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: AppGaps.hGap10),
                  SliverToBoxAdapter(
                    child: Text(
                      AppLanguageTranslation
                          .selectTopUpMethodTransKey.toCurrentLanguage,
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap14),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      /// Single payment Option
                      final FakePaymentOptionModel fakePaymentOption =
                          FakeData.paymentOptions[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: PaymentOptionListTileWidget(
                          /* hasShadow:
                              controller.selectedSavedWithdrawMethod.id ==
                                  withdrawMethod.id, */
                          onTap: () {},
                          paymentImageURL: fakePaymentOption.paymentImage,
                          // paymentIconWidget: withdrawMethod.paymentImage,
                          paymentName: fakePaymentOption.name,
                        ),
                      );
                    },
                    childCount: FakeData.paymentOptions.length,
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap10),
                  /*  const SliverToBoxAdapter(
                    child: Text(
                      'Top Up Amount',
                      style: AppTextStyles.bodyLargeMediumTextStyle,
                    ),
                  ), */
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: controller.topUpAmount,
                      labelText: AppLanguageTranslation
                          .topUpAmountTransKey.toCurrentLanguage,
                      hintText: AppLanguageTranslation
                          .enterYourAmountTransKey.toCurrentLanguage,
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.dollerSVGLogoSolid),
                    ),
                  ),
                  /*  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  const SliverToBoxAdapter(
                    child: CustomTextFormField(
                      hintText: 'Enter your amount',
                      prefixIcon: SvgPictureAssetWidget(
                          AppAssetImages.dollarSqureSVGLogoLine),
                    ),
                  ), */
                  /*   const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomStretchedOutlinedButtonWidget(
                            child: const Text(
                              'Add Card',
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                            onTap: () {
                              Get.toNamed(AppPageNames.addCardScreen);
                            },
                          ),
                        ),
                        AppGaps.wGap10,
                        Expanded(
                          child: CustomStretchedOutlinedButtonWidget(
                            child: Text(
                              'Card Screen',
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                            onTap: () {
                              Get.toNamed(AppPageNames.savedcardListScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                  ), */
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomStretchedButtonWidget(
                    onTap: controller.topUpWallet,
                    child: Text(
                      AppLanguageTranslation.tpUpTransKey.toCurrentLanguage,
                    ),
                  ),
                  AppGaps.hGap20,
                ],
              )),
            ));
  }
}
