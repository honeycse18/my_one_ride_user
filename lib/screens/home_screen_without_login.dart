import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/home_screen_without_login_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/screenParameters/car_rent_screen_parameter.dart';
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
import 'package:one_ride_user/widgets/screen_widget/select_car_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreenWithoutLogin extends StatelessWidget {
  const HomeScreenWithoutLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenWithoutLoginController>(
        init: HomeScreenWithoutLoginController(),
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
                          mapToolbarEnabled: true,
                          zoomControlsEnabled: false,
                          myLocationEnabled: false,
                          myLocationButtonEnabled: true,
                          compassEnabled: true,
                          zoomGesturesEnabled: false,
                          initialCameraPosition:
                              AppSingleton.instance.defaultCameraPosition,
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 110.0,
                    ),
                    child: CustomTextFormField(
                      onTap: () {
                        controller.onLocationEditTap();
                      },
                      isReadOnly: true,
                      prefixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.searchSVGLogoLine),
                      hintText: controller.address != ''
                          ? controller.address
                          : AppLanguageTranslation
                              .selectLocationTransKey.toCurrentLanguage,
                    ),
                  ),
                  SlidingUpPanel(
                    color: Colors.transparent,
                    boxShadow: null,
                    isDraggable: false,
                    minHeight: MediaQuery.of(context).size.height * 0.75,
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                    panel: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .nearestRidesTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .titleSemiSmallSemiboldTextStyle,
                                          ),
                                          RawButtonWidget(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppPageNames
                                                      .rideListCarScreen,
                                                  arguments: SendLocationParams(
                                                    lat:
                                                        controller.passLatitude,
                                                    lng: controller
                                                        .passLongitude,
                                                    withoutLogin: true,
                                                  ));
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .seeAllTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyMediumTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap16,
                                    ),
                                    controller.rides.isNotEmpty
                                        ? SliverList.separated(
                                            itemCount:
                                                controller.rides.length > 5
                                                    ? 5
                                                    : controller.rides.length,
                                            itemBuilder: (context, index) {
                                              NearestCarsListRide ride =
                                                  controller.rides[index];
                                              return SelectHomeCarWidget(
                                                  onTap: () {
                                                    Helper
                                                        .showTopSnackbarWithMessage(
                                                      'Please Login for Booking Your Ride ',
                                                      onActionButtonTap: () {
                                                        Get.toNamed(AppPageNames
                                                            .logInScreen);
                                                      },
                                                    );
                                                  },
                                                  vehicleCategory: ride
                                                      .vehicle.category.name,
                                                  fuelType: ride.vehicle.color,
                                                  seat: ride.vehicle.capacity,
                                                  carImage: ride.vehicle.images
                                                          .firstOrNull ??
                                                      '',
                                                  amount: 0,
                                                  transportName:
                                                      ride.vehicle.name,
                                                  distanceInTime:
                                                      ride.driver.time.text);
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.hGap16,
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
                                                      'No Rides Found In your Current Location'),
                                            ),
                                          ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap24,
                                    ),
                                    SliverToBoxAdapter(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .rentCarTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                          RawButtonWidget(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppPageNames.rentCarScreen,
                                                  arguments: SendLocationParams(
                                                    lat:
                                                        controller.passLatitude,
                                                    lng: controller
                                                        .passLongitude,
                                                    withoutLogin: true,
                                                  ));
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .seeAllTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyMediumTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap10,
                                    ),
                                    controller.rentCarList.isNotEmpty
                                        ? SliverToBoxAdapter(
                                            child: SizedBox(
                                                height: 255,
                                                child: ListView.separated(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final rentCarList =
                                                          controller
                                                                  .rentCarList[
                                                              index];
                                                      return RentCarListItemWidget(
                                                        address:
                                                            rentCarList.address,
                                                        fuelType: rentCarList
                                                            .vehicle.fuelType,
                                                        gearType: rentCarList
                                                            .vehicle.gearType,
                                                        seat: rentCarList
                                                            .vehicle.capacity,
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

                                                          controller.update();
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
                                                          controller.update();
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
                                                          controller.update();
                                                        },
                                                        hourlyRate: rentCarList
                                                            .prices
                                                            .hourly
                                                            .price,
                                                        weeklyRate: rentCarList
                                                            .prices
                                                            .weekly
                                                            .price,
                                                        monthlyRate: rentCarList
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
                                                            rentCarList.vehicle
                                                                .category.name,
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
                                                        : controller.rentCarList
                                                            .length)),
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

                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap10,
                                    ),
                                    SliverToBoxAdapter(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLanguageTranslation
                                                .hireDriverTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .notificationDateSection,
                                          ),
                                          RawButtonWidget(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppPageNames
                                                      .addHireDriverScreen,
                                                  arguments: SendLocationParams(
                                                    lat:
                                                        controller.passLatitude,
                                                    lng: controller
                                                        .passLongitude,
                                                    withoutLogin: true,
                                                  ));
                                            },
                                            child: Text(
                                              AppLanguageTranslation
                                                  .seeAllTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodyMediumTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: AppGaps.hGap16,
                                    ),
                                    controller.nearestDriverList.isNotEmpty
                                        ? SliverList.separated(
                                            itemBuilder: (context, index) {
                                              final nearestDriverList =
                                                  controller
                                                      .nearestDriverList[index];

                                              return AddHireDriverListItemWidget(
                                                isOnTapNeed: true,
                                                onTap: () {
                                                  Helper
                                                      .showTopSnackbarWithMessage(
                                                    'Please Login for hiring driver ',
                                                    onActionButtonTap: () {
                                                      Get.toNamed(AppPageNames
                                                          .logInScreen);
                                                    },
                                                  );
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
                                                      isScrollControlled: true,
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
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
