import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/picked_location_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/recent_location_response.dart';
import 'package:one_ride_user/models/api_responses/saved_location_list_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class PickedLocationScreen extends StatelessWidget {
  const PickedLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /* final controller = Get.find<PickedLocationScreenController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.pickUpLocationFocusNode.requestFocus();
      FocusManager.instance.primaryFocus?.unfocus(); // Hide the keyboard
    }); */
    return GetBuilder<PickedLocationScreenController>(
        global: false,
        init: PickedLocationScreenController(),
        builder: (controller) => Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: const Color(0xFFF7F7FB),
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .selectAddressTransKey.toCurrentLanguage)),
              body: SafeArea(
                child: ScaffoldBodyWidget(
                    child: Column(
                  children: [
                    Column(
                      children: [
                        if (Platform.isIOS) AppGaps.hGap40,
                        LocationPickUpTextFormField(
                          onTap: controller.onFocusChange,
                          focusNode: controller.pickUpLocationFocusNode,
                          controller: controller.pickUpLocationTextController,
                          hintText: AppLanguageTranslation
                              .pickUpTransKey.toCurrentLanguage,
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.pickLocationSVGLogoLine),
                          suffixIcon: controller
                                  .pickUpLocationTextController.text.isNotEmpty
                              ? TightIconButtonWidget(
                                  onTap: () {
                                    controller
                                        .pickUpLocationTextController.text = '';
                                    controller.pickUpLocationFocusNode
                                        .requestFocus();
                                    controller.update();
                                  },
                                  icon: Image.asset(
                                    AppAssetImages.crossImage,
                                    height: 14,
                                    width: 14,
                                  ),
                                )
                              : null,
                        ),
                        LocationPickDownTextFormField(
                          onTap: controller.onFocusChange,
                          focusNode: controller.dropLocationFocusNode,
                          controller: controller.dropLocationTextController,
                          hintText: AppLanguageTranslation
                              .dropLocTransKey.toCurrentLanguage,
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.solidLocationSVGLogoLine),
                          suffixIcon: controller
                                  .dropLocationTextController.text.isNotEmpty
                              ? TightIconButtonWidget(
                                  onTap: () {
                                    controller.dropLocationTextController.text =
                                        '';
                                    controller.dropLocationFocusNode
                                        .requestFocus();
                                    controller.update();
                                  },
                                  icon: Image.asset(
                                    AppAssetImages.crossImage,
                                    height: 14,
                                    width: 14,
                                  ),
                                )
                              : null,
                        ),
                        AppGaps.hGap24,
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if (!controller.locateOnMapSelected)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLanguageTranslation
                                      .savedLocationTransKey.toCurrentLanguage,
                                  style: AppTextStyles
                                      .titleSemiSmallSemiboldTextStyle,
                                ),
                                AppGaps.hGap12,
                                SizedBox(
                                  height: controller.savedLocations.length > 5
                                      ? 250
                                      : controller.savedLocations.length * 50,
                                  child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        SavedLocationListSingleLocation
                                            location =
                                            controller.savedLocations[index];

                                        List<String> icons = [
                                          AppAssetImages.homeDarkSVGLogoSolid,
                                          AppAssetImages.officeDarkSVGLogoSolid,
                                          AppAssetImages.mallDarkSVGLogoSolid
                                        ];
                                        final String icon;
                                        if (location.label == 'Home') {
                                          icon = icons[0];
                                        } else if (location.label == 'Office') {
                                          icon = icons[1];
                                        } else {
                                          icon = icons[2];
                                        }
                                        return RawButtonWidget(
                                          onTap: () => controller
                                              .onSavedLocationTap(location),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SvgPictureAssetWidget(
                                                icon,
                                                color: AppColors.bodyTextColor,
                                              ),
                                              AppGaps.wGap12,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      location.label == 'Other'
                                                          ? location.name
                                                          : location.label,
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle,
                                                    ),
                                                    AppGaps.hGap4,
                                                    Text(
                                                      location.address,
                                                      style: AppTextStyles
                                                          .bodyTextStyle,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          AppGaps.hGap10,
                                      itemCount:
                                          controller.savedLocations.length),
                                ),
                                if (controller.recentLocations.isNotEmpty)
                                  AppGaps.hGap24,
                                if (controller.recentLocations.isNotEmpty)
                                  Text(
                                    AppLanguageTranslation
                                        .recentLocationTransKey
                                        .toCurrentLanguage,
                                    style: AppTextStyles
                                        .titleSemiSmallSemiboldTextStyle,
                                  ),
                                AppGaps.hGap12,
                                SizedBox(
                                  height: controller.recentLocations.length > 5
                                      ? 250
                                      : controller.recentLocations.length * 50,
                                  child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        RecentLocationsData location =
                                            controller.recentLocations[index];
                                        return RawButtonWidget(
                                          onTap: () => controller
                                              .onSavedLocationTap(location),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SvgPictureAssetWidget(
                                                AppAssetImages
                                                    .solidLocationSVGLogoLine,
                                                color: AppColors.bodyTextColor,
                                              ),
                                              AppGaps.wGap12,
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLanguageTranslation
                                                          .recentTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodyLargeSemiboldTextStyle,
                                                    ),
                                                    AppGaps.hGap4,
                                                    Text(
                                                      location.address,
                                                      style: AppTextStyles
                                                          .bodyTextStyle,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          AppGaps.hGap10,
                                      itemCount:
                                          controller.recentLocations.length),
                                )
                                /* const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPictureAssetWidget(
                                          AppAssetImages
                                              .solidLocationSVGLogoLine,
                                          color: AppColors.bodyTextColor,
                                        ),
                                        AppGaps.wGap12,
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Shopping center',
                                                style: AppTextStyles
                                                    .bodyLargeSemiboldTextStyle,
                                              ),
                                              AppGaps.hGap4,
                                              Text(
                                                '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                                                style:
                                                    AppTextStyles.bodyTextStyle,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ), */
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              bottomNavigationBar: ScaffoldBottomBarWidget(
                  backgroundColor: Colors.white,
                  padding: AppGaps.bottomNavBarPadding.copyWith(
                    top: 10,
                    bottom: context.mediaQueryViewInsets.bottom +
                        /* context.mediaQueryViewPadding.bottom + */
                        10,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        controller.pickUpLocationFocusNode.hasFocus
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                    children: [
                      if (controller.pickUpLocationFocusNode.hasFocus)
                        GestureDetector(
                          onTap: () => controller.getCurrentPosition(context),
                          child: Row(children: [
                            SvgPictureAssetWidget(
                              AppAssetImages.currentLocationSVGLogoLine,
                            ),
                            AppGaps.wGap10,
                            Text(
                              AppLanguageTranslation
                                  .currentLocationTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                        ),
                      GestureDetector(
                        onTap: controller.onLocateOnMapButtonTap,
                        child: Row(children: [
                          const Image(
                            height: 16,
                            width: 16,
                            image: AssetImage(
                              AppAssetImages.locateOnMapLogoLine,
                            ),
                            color: /* controller.locateOnMapSelected
                                ? null
                                :  */
                                AppColors.bodyTextColor,
                          ),
                          AppGaps.wGap10,
                          Text(
                              AppLanguageTranslation
                                  .locateOnMapTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: /*  controller.locateOnMapSelected
                                    ? null
                                    :  */
                                    AppColors.bodyTextColor,
                              ))
                        ]),
                      )
                    ],
                  )),
            ));
  }
}
