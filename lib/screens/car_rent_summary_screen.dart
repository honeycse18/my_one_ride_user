import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/car_rent_summary_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarRentSummaryScreen extends StatelessWidget {
  const CarRentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarRentSummaryScreenController>(
        global: false,
        init: CarRentSummaryScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.postRentDetails.vehicle.name)),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: AppGaps.hGap15),
                  SliverToBoxAdapter(
                    child: Text(
                      controller.postRentDetails.vehicle.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap2),
                  SliverToBoxAdapter(
                    child: Text(
                      controller.postRentDetails.vehicle.category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLargeTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap18),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 150,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            height: 136,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primaryBorderColor),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: PageView.builder(
                                    controller: controller.imageController,
                                    scrollDirection: Axis.horizontal,
                                    /* onPageChanged: (index) {
                                    controller.images =
                                        controller.vehicleDetailsItem.images;
                                    controller.update();
                                  }, */
                                    itemCount: controller
                                        .postRentDetails.vehicle.images.length,
                                    itemBuilder: (context, index) {
                                      final images = controller.postRentDetails
                                          .vehicle.images[index];
                                      return CachedNetworkImageWidget(
                                        imageURL: images,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: AppComponents
                                                  .imageBorderRadius,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain)),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SmoothPageIndicator(
                              controller: controller.imageController,
                              count: controller
                                      .postRentDetails.vehicle.images.isEmpty
                                  ? 1
                                  : controller
                                      .postRentDetails.vehicle.images.length,
                              axisDirection: Axis.horizontal,
                              effect: const ExpandingDotsEffect(
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 2,
                                  expansionFactor: 3,
                                  activeDotColor: AppColors.primaryColor,
                                  dotColor: AppColors.bodyTextColor),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap24),
                  controller.postRentDetails.driver.id.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: Text(
                            AppLanguageTranslation
                                .driverTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationDateSection,
                          ),
                        )
                      : const SliverToBoxAdapter(child: AppGaps.emptyGap),
                  controller.postRentDetails.driver.id.isNotEmpty
                      ? const SliverToBoxAdapter(child: AppGaps.hGap16)
                      : const SliverToBoxAdapter(child: AppGaps.emptyGap),
                  controller.postRentDetails.driver.id.isNotEmpty
                      ? SliverToBoxAdapter(
                          child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              padding: EdgeInsets.all(16),
                              height: 87,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primaryBorderColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14)),
                                  color: Colors.white),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 65,
                                      width: 65,
                                      child: CachedNetworkImageWidget(
                                        imageURL: controller
                                            .postRentDetails.driver.image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: AppComponents
                                                  .imageBorderRadius,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    AppGaps.wGap20,
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .postRentDetails.driver.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles
                                                .bodyLargeSemiboldTextStyle,
                                          ),
                                          const SingleStarWidget(review: 4.9),
                                        ],
                                      ),
                                    ),
                                    RawButtonWidget(
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors
                                                    .primaryBorderColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                        child: const Center(
                                            child: SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .messageTextSVGLogoSolid)),
                                      ),
                                      onTap: () {
                                        Get.toNamed(AppPageNames.chatScreen,
                                            arguments: controller
                                                .postRentDetails.driver.id);
                                      },
                                    ),
                                    AppGaps.wGap8,
                                    Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors
                                                    .primaryBorderColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                        child: const Center(
                                            child: SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .callingSVGLogoSolid))),
                                  ]),
                            ))
                          ],
                        ))
                      : const SliverToBoxAdapter(child: AppGaps.emptyGap),
                  controller.postRentDetails.driver.id.isNotEmpty
                      ? const SliverToBoxAdapter(child: AppGaps.hGap24)
                      : const SliverToBoxAdapter(child: AppGaps.emptyGap),
                  SliverToBoxAdapter(
                    child: Text(
                      AppLanguageTranslation
                          .startDateTimeTransKey.toCurrentLanguage,
                      style: AppTextStyles.bodyLargeMediumTextStyle,
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap10),
                  SliverToBoxAdapter(
                      child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 62,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: Row(
                      children: [
                        const SvgPictureAssetWidget(
                          AppAssetImages.calenderSVGLogoLine,
                          height: 18,
                          width: 18,
                        ),
                        AppGaps.wGap8,
                        Text(Helper.ddMMMyyyyhhmmFormattedDateTime(
                            controller.postRentDetails.date))
                      ],
                    ),
                  )),
                  /*  const SliverToBoxAdapter(child: AppGaps.hGap24),
                  SliverToBoxAdapter(
                      child: CustomTextFormField(
                    labelText: AppLanguageTranslation
                        .applyCouponTransKey.toCurrentLanguage,
                    hintText: AppLanguageTranslation
                        .couponCodeTransKey.toCurrentLanguage,
                    prefixIcon: AppGaps.emptyGap,
                    suffixIcon: RawButtonWidget(
                      child: const SvgPictureAssetWidget(
                        AppAssetImages.applySVGLogoLine,
                        height: 24,
                        width: 24,
                      ),
                      onTap: () {},
                    ),
                  )), */
                  const SliverToBoxAdapter(child: AppGaps.hGap24),
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLanguageTranslation
                                        .otpTransKey.toCurrentLanguage,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                  ),
                                  Text(
                                    controller.postRentDetails.otp,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(child: AppGaps.hGap24),
                  SliverToBoxAdapter(
                      child: Text(
                    AppLanguageTranslation
                        .fareDetailsTransKey.toCurrentLanguage,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Text(
                        AppLanguageTranslation.fareTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      const Spacer(),
                      Text(
                        Helper.getCurrencyFormattedWithDecimalAmountText(
                            controller.postRentDetails.total),
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                    ],
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Text(
                        AppLanguageTranslation.vatTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      const Spacer(),
                      Text(
                        Helper.getCurrencyFormattedWithDecimalAmountText(0),
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                    ],
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Text(
                        AppLanguageTranslation
                            .discountTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeTextStyle
                            .copyWith(color: AppColors.alertColor),
                      ),
                      const Spacer(),
                      Text(
                        '-${Helper.getCurrencyFormattedWithDecimalAmountText(0)}',
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.alertColor),
                      ),
                    ],
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap38),
                  const SliverToBoxAdapter(
                      child: Divider(
                    height: 2,
                    color: AppColors.darkColor,
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap8),
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Spacer(),
                      Text(
                        AppLanguageTranslation
                            .totalFareTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      AppGaps.wGap15,
                      Text(
                          Helper.getCurrencyFormattedWithDecimalAmountText(
                              controller.postRentDetails.total),
                          style: AppTextStyles.bodyLargeMediumTextStyle),
                    ],
                  )),
                  const SliverToBoxAdapter(child: AppGaps.hGap20),
                ],
              )),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomStretchedButtonWidget(
                        child: Text(
                            '${AppLanguageTranslation.paymentTransKey.toCurrentLanguage} => ${controller.postRentDetails.total}'),
                        onTap: controller
                                .postRentDetails.payment.transactionId.isEmpty
                            ? controller.paymentScreen
                            : null),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}
