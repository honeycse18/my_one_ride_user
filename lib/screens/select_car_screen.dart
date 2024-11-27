import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/select_car_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/select_car_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SelectCarScreen extends StatelessWidget {
  const SelectCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectCarScreenController>(
        init: SelectCarScreenController(),
        global: true,
        builder: ((controller) => WillPopScope(
              onWillPop: () async {
                controller.dispose();
                return await Future.value(true);
              },
              child: Scaffold(
                key: controller.bottomSheetFormKey,
                extendBodyBehindAppBar: true,
                extendBody: true,
                backgroundColor: const Color(0xFFF7F7FB),
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context, titleWidget: const Text('')),
                body: Stack(
                  children: [
                    Positioned.fill(
                      bottom: MediaQuery.of(context).size.height * 0.35,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: false,
                        zoomControlsEnabled: false,
                        myLocationEnabled: false,
                        compassEnabled: true,
                        zoomGesturesEnabled: true,
                        initialCameraPosition:
                            // AppSingleton.instance.defaultCameraPosition,
                            CameraPosition(
                                target: LatLng(
                                    (controller.cameraPosition.latitude) - 7.7,
                                    controller.cameraPosition.longitude),
                                zoom: controller.zoomLevel),
                        markers: controller.googleMapMarkers,
                        polylines: controller.googleMapPolyLines,
                        onMapCreated: controller.onGoogleMapCreated,
                        // onTap: controller.onGoogleMapTap,
                      ),
                    ),
                    /* Obx(
                      () => controller.rideAccepted.value
                          ?  */
                    SlidingUpPanel(
                        color: Colors.transparent,
                        boxShadow: null,
                        minHeight: 372,
                        maxHeight: 600,
                        panel: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.topLeft,
                            decoration: const BoxDecoration(
                              color: AppColors.mainBg,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              children: [
                                AppGaps.hGap10,
                                Container(
                                  width: 60,
                                  decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 3,
                                        strokeAlign:
                                            BorderSide.strokeAlignCenter,
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
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      slivers: [
                                        const SliverToBoxAdapter(
                                          child: AppGaps.hGap8,
                                        ),
                                        SliverToBoxAdapter(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  // padding: const EdgeInsets.fromLTRB(23, 19, 12, 19),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 23),
                                                  height: 60,
                                                  width: 366,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(18),
                                                              topRight: Radius
                                                                  .circular(
                                                                      18)),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryBorderColor)),
                                                  child: Row(
                                                    children: [
                                                      const SvgPictureAssetWidget(
                                                          AppAssetImages
                                                              .pickLocationSVGLogoLine),
                                                      AppGaps.wGap8,
                                                      Expanded(
                                                        child: Text(
                                                          controller
                                                                  .pickupLocation
                                                                  ?.address ??
                                                              '',
                                                          maxLines: 2,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SliverToBoxAdapter(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 60,
                                                  width: 366,
                                                  // padding: const EdgeInsets.fromLTRB(23, 19, 12, 19),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 23),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              bottomLeft: Radius
                                                                  .circular(18),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          18)),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryBorderColor)),
                                                  child: Row(
                                                    children: [
                                                      const SvgPictureAssetWidget(
                                                          AppAssetImages
                                                              .solidLocationSVGLogoLine),
                                                      AppGaps.wGap8,
                                                      Expanded(
                                                          child: Text(
                                                        controller.dropLocation
                                                                ?.address ??
                                                            '',
                                                        maxLines: 2,
                                                      )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            AppLanguageTranslation
                                                                .editTransKey
                                                                .toCurrentLanguage,
                                                            style: AppTextStyles
                                                                .bodyTextStyle,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (controller.isScheduleRide)
                                          const SliverToBoxAdapter(
                                              child: AppGaps.hGap16),
                                        if (controller.isScheduleRide)
                                          SliverToBoxAdapter(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLanguageTranslation
                                                      .selectTimeTransKey
                                                      .toCurrentLanguage,
                                                  style: AppTextStyles
                                                      .titleSemiSmallBoldTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (controller.isScheduleRide)
                                          const SliverToBoxAdapter(
                                              child: AppGaps.hGap16),
                                        if (controller.isScheduleRide)
                                          SliverToBoxAdapter(
                                            child: CustomTextFormField(
                                              hintText: AppLanguageTranslation
                                                  .startDateTimeTransKey
                                                  .toCurrentLanguage,
                                              isReadOnly: true,
                                              controller: TextEditingController(
                                                text:
                                                    '${DateFormat('dd/MM/yyyy').format(controller.selectedBookingDate.value)}      ${controller.selectedBookingTime.value.hourOfPeriod} : ${controller.selectedBookingTime.value.minute} ${controller.selectedBookingTime.value.period.name}',
                                              ),
                                              prefixIcon:
                                                  const SvgPictureAssetWidget(
                                                      AppAssetImages.calendar),
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(
                                                      DateTime.now().year +
                                                          100),
                                                );
                                                if (pickedDate != null) {
                                                  controller
                                                      .updateSelectedStartDate(
                                                          pickedDate);
                                                }

                                                final TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (pickedTime != null) {
                                                  controller
                                                      .updateSelectedStartTime(
                                                          pickedTime);
                                                }

                                                controller.update();
                                              },
                                            ),
                                          ),
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                        SliverToBoxAdapter(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLanguageTranslation
                                                    .nearestToYouTransKey
                                                    .toCurrentLanguage,
                                                style: AppTextStyles
                                                    .titleSemiSmallBoldTextStyle,
                                              ),
                                              GestureDetector(
                                                  onTap: controller
                                                      .onResetListButtonTap,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 12),
                                                    child: Text(
                                                      AppLanguageTranslation
                                                          .resetListTransKey
                                                          .toCurrentLanguage,
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .primaryColor),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                        SliverList.separated(
                                            itemBuilder: (context, index) {
                                              NearestCarsListRide ride =
                                                  controller.rides[index];
                                              return SelectCarWidget(
                                                  onTap: () => controller
                                                      .onRideTap(ride),
                                                  isSelected: ride ==
                                                      controller.selectedRide,
                                                  vehicleCategory: ride
                                                      .vehicle.category.name,
                                                  fuelType: ride.vehicle.color,
                                                  seat: ride.vehicle.capacity,
                                                  carImage: ride.vehicle.images
                                                          .firstOrNull ??
                                                      '',
                                                  amount: ride.total,
                                                  transportName:
                                                      ride.vehicle.name,
                                                  distanceInTime:
                                                      ride.driver.time.text);
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.hGap16,
                                            itemCount: controller.rides.length),
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                        SliverToBoxAdapter(
                                          child: Text(
                                            AppLanguageTranslation
                                                .chooseAsYouTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .titleSemiSmallBoldTextStyle,
                                          ),
                                        ),
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap16),
                                        SliverList.separated(
                                            itemBuilder: (context, index) {
                                              NearestCarsListCategory category =
                                                  controller.categories[index];
                                              return SelectCarCategoryPagesWidget(
                                                onTap: () =>
                                                    controller.onCategoryClick(
                                                        category.id),
                                                tagline:
                                                    'Your ride, your choice, our service',
                                                transportName: category.name,
                                                image: category.image,
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    AppGaps.hGap16,
                                            itemCount:
                                                controller.categories.length),
                                        const SliverToBoxAdapter(
                                            child: AppGaps.hGap75)
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                            )))
                    /* : SlidingUpPanel(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              backdropEnabled: false,
                              maxHeight: MediaQuery.of(context).size.height * 0.8,
                              minHeight: MediaQuery.of(context).size.height * 0.4,
                              panel: ), */
                    // ),
                  ],
                ),
                bottomNavigationBar: CustomScaffoldBottomBarWidget(
                    backgroundColor: AppColors.mainBg,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomStretchedButtonWidget(
                          onTap: controller.selectedRide !=
                                  null /* &&
                                  !controller.chainRequest */
                              ? controller.onRideNowButtonTap
                              : null,
                          child: Text(controller.isScheduleRide
                              ? 'Book Now'
                              : 'Ride Now'),
                        ),
                        /* AppGaps.hGap3,
                    CustomStretchedOnlyTextButtonWidget(
                      buttonText: 'Ride Now',
                      onTap: () {},
                    ), */
                      ],
                    )),
              ),
            )));
  }
}
