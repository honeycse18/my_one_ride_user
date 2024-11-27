import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/home_screen_controller.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/hire_driver_bottomsheet.dart';
import 'package:one_ride_user/utils/app_singleton.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/add_hire_driver_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/car_rent_item_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        global: false,
        builder: (controller) => Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Obx(() => GoogleMap(
                          mapType: MapType.normal,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          zoomGesturesEnabled: true,
                          initialCameraPosition:
                              AppSingleton.instance.defaultCameraPosition,
                          /* CameraPosition(
                        target: controller.currentLocation.value ??
                            const LatLng(22.8456, 89.5403),
                        zoom: 14.0,
                      ), */
                          markers: {
                            Marker(
                                markerId: const MarkerId('driver_location'),
                                position: controller.userLocation.value,
                                icon: controller.myCarIcon ??
                                    BitmapDescriptor.defaultMarker),
                          },
                          polylines: controller.googleMapPolylines,
                          onMapCreated: controller.onGoogleMapCreated,
                          onTap: controller.onGoogleMapTap,
                        )),
                  ),
                  SlidingUpPanel(
                    color: Colors.transparent,
                    boxShadow: null,
                    minHeight: MediaQuery.of(context).size.height * 0.4,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                    panel: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 73.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              color: AppColors.mainBg,
                            ),
                            child: Column(children: [
                              AppGaps.hGap10,
                              Container(
                                width: 60,
                                decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: Color(0xFFA5A5A5),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: ScaffoldBodyWidget(
                                    child: CustomScrollView(
                                  slivers: [
                                    SliverToBoxAdapter(
                                      child: Text(
                                        AppLanguageTranslation
                                            .choseYourRideTransKey
                                            .toCurrentLanguage,
                                        style: AppTextStyles
                                            .titleSemiSmallSemiboldTextStyle,
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap16,
                                    ),
                                    SliverToBoxAdapter(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            RawButtonWidget(
                                              borderRadiusValue: 12,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                height: 77,
                                                width: 110,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Column(children: [
                                                  const SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .rideNow1SVGLogoLine,
                                                    height: 28,
                                                    width: 28,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  AppGaps.hGap4,
                                                  Text(
                                                      AppLanguageTranslation
                                                          .rideNowYTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySmallMediumTextStyle
                                                          .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ))
                                                ]),
                                              ),
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPageNames
                                                        .pickedLocationScreen,
                                                    arguments: false);
                                              },
                                            ),
                                            AppGaps.wGap16,
                                            RawButtonWidget(
                                              borderRadiusValue: 12,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                height: 77,
                                                width: 110,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Column(children: [
                                                  const SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .calenderAddSVGLogoLine,
                                                    height: 28,
                                                    width: 28,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  Text(
                                                      AppLanguageTranslation
                                                          .scheduleRideTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySmallMediumTextStyle
                                                          .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ))
                                                ]),
                                              ),
                                              onTap: () {
                                                Get.toNamed(
                                                    AppPageNames
                                                        .pickedLocationScreen,
                                                    arguments: true);
                                              },
                                            ),
                                            AppGaps.wGap16,
                                            RawButtonWidget(
                                              borderRadiusValue: 12,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                height: 77,
                                                width: 110,
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                                child: Column(children: [
                                                  const SvgPictureAssetWidget(
                                                    AppAssetImages
                                                        .multiplePeopleSVGLogoLine,
                                                    height: 28,
                                                    width: 28,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  Text(
                                                      AppLanguageTranslation
                                                          .shareRideTransKey
                                                          .toCurrentLanguage,
                                                      style: AppTextStyles
                                                          .bodySmallMediumTextStyle
                                                          .copyWith(
                                                        color: AppColors
                                                            .primaryColor,
                                                      ))
                                                ]),
                                              ),
                                              onTap: () {
                                                Get.toNamed(AppPageNames
                                                    .rideShareScreen);
                                              },
                                            ),
                                            AppGaps.wGap16,
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap24,
                                    ),
                                    SliverToBoxAdapter(
                                      child: Text(
                                        AppLanguageTranslation
                                            .rentCarTransKey.toCurrentLanguage,
                                        style: AppTextStyles
                                            .notificationDateSection,
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap10,
                                    ),
                                    controller.rentCarList.isNotEmpty
                                        ? SliverToBoxAdapter(
                                            child: SizedBox(
                                                height: 255,
                                                child: controller
                                                        .userDetailsData
                                                        .country
                                                        .id
                                                        .isNotEmpty
                                                    ? ListView.separated(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final rentCarList =
                                                              controller
                                                                      .rentCarList[
                                                                  index];
                                                          return RentCarListItemWidget(
                                                            address: rentCarList
                                                                .address,
                                                            fuelType:
                                                                rentCarList
                                                                    .vehicle
                                                                    .fuelType,
                                                            gearType:
                                                                rentCarList
                                                                    .vehicle
                                                                    .gearType,
                                                            seat: rentCarList
                                                                .vehicle
                                                                .capacity,
                                                            onMonthlyTap: () {
                                                              rentCarList
                                                                      .isMonthlySelected =
                                                                  true;
                                                              rentCarList
                                                                      .isHourlySelected =
                                                                  false;
                                                              rentCarList
                                                                      .isWeeklySelected =
                                                                  false;

                                                              controller
                                                                  .update();
                                                            },
                                                            onWeeklyTap: () {
                                                              rentCarList
                                                                      .isHourlySelected =
                                                                  false;
                                                              rentCarList
                                                                      .isWeeklySelected =
                                                                  true;
                                                              rentCarList
                                                                      .isMonthlySelected =
                                                                  false;
                                                              controller
                                                                  .update();
                                                            },
                                                            onHourlyTap: () {
                                                              rentCarList
                                                                      .isHourlySelected =
                                                                  true;
                                                              rentCarList
                                                                      .isWeeklySelected =
                                                                  false;
                                                              rentCarList
                                                                      .isMonthlySelected =
                                                                  false;
                                                              controller
                                                                  .update();
                                                            },
                                                            hourlyRate:
                                                                rentCarList
                                                                    .prices
                                                                    .hourly
                                                                    .price,
                                                            weeklyRate:
                                                                rentCarList
                                                                    .prices
                                                                    .weekly
                                                                    .price,
                                                            monthlyRate:
                                                                rentCarList
                                                                    .prices
                                                                    .monthly
                                                                    .price,
                                                            isHourlySelected:
                                                                rentCarList
                                                                    .isHourlySelected,
                                                            isMonthlySelected:
                                                                rentCarList
                                                                    .isMonthlySelected,
                                                            isWeeklySelected:
                                                                rentCarList
                                                                    .isWeeklySelected,
                                                            review: 0.0,
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  AppPageNames
                                                                      .carDetailsScreen,
                                                                  arguments:
                                                                      rentCarList
                                                                          .id);
                                                            },
                                                            carImage: Helper
                                                                .getFirstSafeString(
                                                                    rentCarList
                                                                        .vehicle
                                                                        .images),
                                                            carName: rentCarList
                                                                .vehicle.name,
                                                            carCategoryName:
                                                                rentCarList
                                                                    .vehicle
                                                                    .category
                                                                    .name,
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                AppGaps.wGap16,
                                                        itemCount: controller
                                                                    .rentCarList
                                                                    .length >
                                                                5
                                                            ? 5
                                                            : controller
                                                                .rentCarList
                                                                .length)
                                                    : Center(
                                                        child: TextButton(
                                                            onPressed:
                                                                () async {
                                                              await Get.toNamed(
                                                                  AppPageNames
                                                                      .myProfileScreen);
                                                              controller
                                                                  .onInit();
                                                            },
                                                            child: Text(AppLanguageTranslation
                                                                .addCountryTransKey
                                                                .toCurrentLanguage)),
                                                      )),
                                          )
                                        : const SliverToBoxAdapter(
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: EmptySmallScreenWidget(
                                                  height: 60,
                                                  isSVGImage: true,
                                                  localImageAssetURL:
                                                      AppAssetImages
                                                          .rentCarSVGLogoLine,
                                                  title:
                                                      'No Rent Found In your Current Location'),
                                            ),
                                          ),
                                    /* const SliverToBoxAdapter(
                                      child: Divider(),
                                    ), */
                                    if (controller
                                        .userDetailsData.country.id.isNotEmpty)
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap10,
                                      ),
                                    if (controller
                                        .userDetailsData.country.id.isNotEmpty)
                                      SliverToBoxAdapter(
                                        child: Text(
                                          AppLanguageTranslation
                                              .hireDriverTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .notificationDateSection,
                                        ),
                                      ),
                                    if (controller
                                        .userDetailsData.country.id.isNotEmpty)
                                      const SliverToBoxAdapter(
                                        child: AppGaps.hGap16,
                                      ),
                                    if (controller
                                        .userDetailsData.country.id.isNotEmpty)
                                      controller.nearestDriverList.isNotEmpty
                                          ? SliverList.separated(
                                              itemBuilder: (context, index) {
                                                final nearestDriverList =
                                                    controller
                                                            .nearestDriverList[
                                                        index];

                                                return AddHireDriverListItemWidget(
                                                  isOnTapNeed:
                                                      Helper.isUserLoggedIn()
                                                          ? true
                                                          : false,
                                                  onTap: () {
                                                    Get.bottomSheet(
                                                        const HireDriverBottomSheet(),
                                                        settings: RouteSettings(
                                                            arguments:
                                                                nearestDriverList),
                                                        isScrollControlled:
                                                            true,
                                                        ignoreSafeArea: false);
                                                  },
                                                  driverExperience: 0,
                                                  driverImage:
                                                      nearestDriverList.image,
                                                  driverName:
                                                      nearestDriverList.name,
                                                  driverRides: 0,
                                                  location:
                                                      nearestDriverList.address,
                                                  rate: nearestDriverList.rate,
                                                  rating: 0,
                                                  onhireTap: () {
                                                    Get.bottomSheet(
                                                        const HireDriverBottomSheet(),
                                                        settings: RouteSettings(
                                                            arguments:
                                                                nearestDriverList),
                                                        isScrollControlled:
                                                            true,
                                                        ignoreSafeArea: false);
                                                  },
                                                );
                                              },
                                              itemCount: controller
                                                          .nearestDriverList
                                                          .length >
                                                      5
                                                  ? 5
                                                  : controller
                                                      .nearestDriverList.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      AppGaps.hGap24)
                                          : const SliverToBoxAdapter(
                                              child: EmptySmallScreenWidget(
                                                  height: 60,
                                                  isSVGImage: true,
                                                  localImageAssetURL:
                                                      AppAssetImages
                                                          .rentCarSVGLogoLine,
                                                  title:
                                                      'No Driver Found In your Current Location'),
                                            ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap80,
                                    ),
                                  ],
                                )),
                              ))
                            ]),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 27,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14)),
                              child: IconButtonWidget(
                                backgroundColor: Colors.white,
                                onTap: () {
                                  controller.getCurrentLocation();
                                  log('message');
                                },
                                child: const SvgPictureAssetWidget(
                                    AppAssetImages.locationSVGLogoLine,
                                    color: AppColors.primaryColor),
                              ),
                            ))
                      ],
                    ),
                  ),
                  /* Positioned(
                      bottom: 114,
                      left: 24,
                      right: 24,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Positioned(
                              top: 5,
                              child: IconButtonWidget(
                                backgroundColor: Colors.white,
                                onTap: () {
                                  controller.getCurrentLocation();
                                  log('message');
                                },
                                child: const SvgPictureAssetWidget(
                                    AppAssetImages.locationSVGLogoLine,
                                    color: AppColors.primaryColor),
                              ),
                            ),
        
                            /* SizedBox(
                              height: 88,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.topCenter,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7FB),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Center(
                                    child: CustomTextFormField(
                                  isReadOnly: true,
                                  textInputType: TextInputType.datetime,
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.pickedLocationScreen);
                                  },
                                  hintText: 'Where would you go?',
                                  hasShadow: true,
                                  maxLines: 1,
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.searchSVGLogoLine),
                                )),
                              ),
                            ), */
                          ],
                        ),
                      )), */
                ],
              ),
            ));
  }
}
