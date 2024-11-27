import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/vehicle_details_information_screen_controller.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/car_rent_book_bottomsheet.dart';
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
import 'package:one_ride_user/widgets/screen_widget/vehicle_features_item_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/vehicle_list_tab_screen_widget.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleDetailsInfoScreenController>(
        global: false,
        init: VehicleDetailsInfoScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .carDetailsTransKey.toCurrentLanguage),
                  actions: [
                    /* Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 40,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: TextButton(
                          onPressed: controller.onEditButtonTap,
                          child: Text(
                            'Edit',
                            style: AppTextStyles.bodySmallMediumTextStyle
                                .copyWith(decoration: TextDecoration.underline),
                          )),
                    ) */
                  ]),
              body: ScaffoldBodyWidget(
                  child: CustomScrollView(slivers: [
                const SliverToBoxAdapter(child: AppGaps.hGap15),
                SliverToBoxAdapter(
                  child: Text(
                    controller.carRentDetails.vehicle.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap2),
                SliverToBoxAdapter(
                  child: Text(
                    controller.carRentDetails.vehicle.category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyLargeTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ),
                const SliverToBoxAdapter(child: AppGaps.hGap18),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 250,
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          height: 236,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primaryBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
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
                                      .carRentDetails.vehicle.images.length,
                                  itemBuilder: (context, index) {
                                    final images = controller
                                        .carRentDetails.vehicle.images[index];
                                    return CachedNetworkImageWidget(
                                      imageURL: images,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                AppComponents.imageBorderRadius,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fitWidth)),
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
                            count:
                                controller.carRentDetails.vehicle.images.isEmpty
                                    ? 1
                                    : controller
                                        .carRentDetails.vehicle.images.length,
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
                const SliverToBoxAdapter(child: AppGaps.hGap32),
                SliverToBoxAdapter(
                    child: SizedBox(
                        height: 50,
                        child: Obx(() => Row(
                              children: [
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: CarDetailsInfoTypeStatus
                                      .specifications.stringValueForView,
                                  isSelected: controller
                                          .vehicleInfoStatusTab.value ==
                                      CarDetailsInfoTypeStatus.specifications,
                                  onTap: () {
                                    controller.onTabTap(CarDetailsInfoTypeStatus
                                        .specifications);
                                  },
                                )),
                                AppGaps.wGap10,
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: CarDetailsInfoTypeStatus
                                      .features.stringValueForView,
                                  isSelected:
                                      controller.vehicleInfoStatusTab.value ==
                                          CarDetailsInfoTypeStatus.features,
                                  onTap: () {
                                    controller.onTabTap(
                                        CarDetailsInfoTypeStatus.features);
                                  },
                                )),
                                AppGaps.wGap10,
                                Expanded(
                                    child: ListTabStatusWidget(
                                  text: CarDetailsInfoTypeStatus
                                      .documents.stringValueForView,
                                  isSelected:
                                      controller.vehicleInfoStatusTab.value ==
                                          CarDetailsInfoTypeStatus.documents,
                                  onTap: () {
                                    controller.onTabTap(
                                        CarDetailsInfoTypeStatus.documents);
                                  },
                                )),
                              ],
                            )))),
                const SliverToBoxAdapter(child: AppGaps.hGap24),
                Obx(() {
                  switch (controller.vehicleInfoStatusTab.value) {
                    case CarDetailsInfoTypeStatus.specifications:
                      return SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppAssetImages.maxpowerPng,
                                        height: 19,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        AppLanguageTranslation
                                            .maxPowerTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        controller
                                            .carRentDetails.vehicle.maxPower,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              AppGaps.wGap16,
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppAssetImages.maxSpeedPng,
                                        height: 19,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        AppLanguageTranslation
                                            .maxSpeedTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        controller
                                            .carRentDetails.vehicle.maxSpeed,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              AppGaps.wGap16,
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppAssetImages.mileagePng,
                                        height: 19,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        AppLanguageTranslation
                                            .mileageTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        '${controller.carRentDetails.vehicle.maxPower} hp',
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              AppGaps.wGap16,
                              Expanded(
                                child: Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AppAssetImages.seatPng,
                                        height: 19,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        AppLanguageTranslation
                                            .seatTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                      AppGaps.hGap2,
                                      Text(
                                        '${controller.carRentDetails.vehicle.capacity} seat',
                                        style: AppTextStyles
                                            .smallestMediumTextStyle,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          ),
                          AppGaps.hGap23,
                          Text(
                            AppLanguageTranslation
                                .carOwnerTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationDateSection,
                          ),
                          AppGaps.hGap8,
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(16),
                                height: 87,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryBorderColor),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)),
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
                                              .carRentDetails.owner.image,
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
                                                  .carRentDetails.owner.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle,
                                            ),
                                            const SingleStarWidget(review: 4.9),
                                          ],
                                        ),
                                      ),
                                      if (Helper.isUserLoggedIn())
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
                                                        Radius.circular(14))),
                                            child: const Center(
                                                child: SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .messageTextSVGLogoSolid)),
                                          ),
                                          onTap: () {
                                            Get.toNamed(AppPageNames.chatScreen,
                                                arguments: controller
                                                    .carRentDetails.owner.id);
                                          },
                                        ),
                                      AppGaps.wGap10,
                                      /* if (Helper.isUserLoggedIn())
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors
                                                      .primaryBorderColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(14))),
                                          child: const Center(
                                              child: SvgPictureAssetWidget(
                                                  AppAssetImages
                                                      .callingSVGLogoSolid)),
                                        ), */
                                    ]),
                              ))
                            ],
                          ),
                          AppGaps.hGap23,
                          controller.carRentDetails.hasDriver
                              ? Text(
                                  AppLanguageTranslation
                                      .driverTransKey.toCurrentLanguage,
                                  style: AppTextStyles.notificationDateSection,
                                )
                              : AppGaps.emptyGap,
                          controller.carRentDetails.hasDriver
                              ? AppGaps.hGap8
                              : AppGaps.emptyGap,
                          controller.carRentDetails.hasDriver
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(16),
                                      height: 87,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  AppColors.primaryBorderColor),
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
                                                    .carRentDetails
                                                    .driver
                                                    .image,
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
                                                    controller.carRentDetails
                                                        .driver.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                  const SingleStarWidget(
                                                      review: 4.9),
                                                ],
                                              ),
                                            ),
                                          ]),
                                    ))
                                  ],
                                )
                              : AppGaps.emptyGap,
                          controller.carRentDetails.hasDriver
                              ? AppGaps.hGap24
                              : AppGaps.emptyGap,
                          Text(
                            AppLanguageTranslation
                                .carZoneTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationDateSection,
                          ),
                          AppGaps.hGap16,
                          Row(
                            children: [
                              const SvgPictureAssetWidget(
                                  AppAssetImages.locateSVGLogoLine),
                              AppGaps.wGap12,
                              Expanded(
                                  child: Text(
                                controller.carRentDetails.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ))
                            ],
                          ),
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .extraFacilitiesTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                          AppGaps.hGap16,
                          Text(
                            AppLanguageTranslation
                                .smokingAllowedTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.hGap8,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(18),
                                    height: 55,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: controller
                                            .carRentDetails.facilities.smoking
                                        ? Text(
                                            AppLanguageTranslation
                                                .yesAllowedTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .bodyLargeTextStyle,
                                          )
                                        : Text(
                                            AppLanguageTranslation
                                                .noAllowedTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .bodyLargeTextStyle,
                                          )),
                              ),
                            ],
                          ),
                          AppGaps.hGap16,
                          Text(
                            AppLanguageTranslation
                                .luggageSpaceTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.hGap8,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.all(18),
                                    height: 55,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Text(
                                      '${controller.carRentDetails.facilities.luggage}',
                                      style: AppTextStyles.bodyLargeTextStyle,
                                    )),
                              ),
                            ],
                          ),
                          AppGaps.hGap36,
                        ],
                      ));
                    case CarDetailsInfoTypeStatus.features:
                      return SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .carFeatureTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .modelTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.model,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .modelTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.year,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .vehicleColorTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.color,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .fuelTypeTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.fuelType,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .gearTypeTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.gearType,
                          ),
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .acTransKey.toCurrentLanguage,
                            featuresvalue: controller.carRentDetails.vehicle.ac
                                ? AppLanguageTranslation
                                    .yesAllowedTransKey.toCurrentLanguage
                                : AppLanguageTranslation
                                    .noAllowedTransKey.toCurrentLanguage,
                          ),
                          AppGaps.hGap16,
                          AppGaps.hGap16,
                        ],
                      ));
                    case CarDetailsInfoTypeStatus.documents:
                      return SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGaps.hGap16,
                          VehicleFeaturesWidget(
                            featuresName: AppLanguageTranslation
                                .numberPlateTransKey.toCurrentLanguage,
                            featuresvalue:
                                controller.carRentDetails.vehicle.vehicleNumber,
                          ),
                          AppGaps.hGap24,
                          /* Text(
                            AppLanguageTranslation
                                .vehicleRegReviewTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.hGap16, */
                          /* SizedBox(
                            height: 220,
                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(
                                  height: 196,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primaryBorderColor),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(18))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: PageView.builder(
                                          controller:
                                              controller.documentController,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller
                                              .carRentDetails
                                              .review
                                              .length,
                                          itemBuilder: (context, index) {
                                            final review = controller
                                                .vehicleDetailsItem
                                                .review[index];
                                            return GestureDetector(
                                              child: CachedNetworkImageWidget(
                                                imageURL: review,
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
                                              ),
                                              onTap: () => Get.toNamed(
                                                  AppPageNames.imageZoomScreen,
                                                  arguments: review),
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
                                    controller: controller.documentController,
                                    count: controller.vehicleDetailsItem
                                            .review.isEmpty
                                        ? 1
                                        : controller.vehicleDetailsItem
                                            .review.length,
                                    axisDirection: Axis.horizontal,
                                    effect: ExpandingDotsEffect(
                                        dotHeight: 12,
                                        dotWidth: 6,
                                        spacing: 2,
                                        expansionFactor: 3,
                                        activeDotColor: AppColors.primaryColor
                                            .withOpacity(0.5),
                                        dotColor: AppColors.bodyTextColor
                                            .withOpacity(0.3)),
                                  ),
                                )
                              ],
                            ),
                          ), */
                        ],
                      ));
                  }
                })
              ])),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Helper.isUserLoggedIn()
                      ? CustomStretchedButtonWidget(
                          child: Text(
                            AppLanguageTranslation
                                .bookNowTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationDateSection,
                          ),
                          onTap: () {
                            Get.bottomSheet(CarRentBookBottomSheet(),
                                settings: RouteSettings(
                                    arguments: controller.carRentDetails));
                          },
                        )
                      : CustomStretchedButtonWidget(
                          child: Text(
                            AppLanguageTranslation
                                .loginTransKey.toCurrentLanguage,
                            style: AppTextStyles.notificationDateSection,
                          ),
                          onTap: () {
                            Get.toNamed(AppPageNames.logInScreen);
                          },
                        ),
                  AppGaps.hGap10,
                ]),
              ),
            ));
  }
}
