import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/menu_screen_controller/hire_driver_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_list_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/hire_driver_list_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/vehicle_list_tab_screen_widget.dart';

class HireDriverScreen extends StatelessWidget {
  const HireDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverScreenController>(
        global: false,
        init: HireDriverScreenController(),
        builder: (controller) => WillPopScope(
              onWillPop: () async {
                controller.onDispose();
                return Future.value(true);
              },
              child: Scaffold(
                  backgroundColor: AppColors.mainBg,
                  appBar: CoreWidgets.appBarWidget(
                      screenContext: context,
                      titleWidget: Text(AppLanguageTranslation
                          .hireDriverTransKey.toCurrentLanguage)),
                  body: ScaffoldBodyWidget(
                    child: RefreshIndicator(
                      onRefresh: () async =>
                          controller.hireDriverPagingController.refresh(),
                      child: CustomScrollView(slivers: [
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap15,
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                                height: 50,
                                child: Obx(() => SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .driverPending
                                                .stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus
                                                    .driverPending,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus
                                                      .driverPending);
                                            },
                                          ),
                                          AppGaps.wGap10,
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .userPending.stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus.userPending,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus
                                                      .userPending);
                                            },
                                          ),
                                          AppGaps.wGap10,
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .accepted.stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus.accepted,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus.accepted);
                                            },
                                          ),
                                          AppGaps.wGap10,
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .started.stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus.started,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus.started);
                                            },
                                          ),
                                          AppGaps.wGap10,
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .completed.stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus.completed,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus
                                                      .completed);
                                            },
                                          ),
                                          AppGaps.wGap10,
                                          ListTabStatusWidget(
                                            text: RideDriverTabStatus
                                                .cancelled.stringValueForView,
                                            isSelected: controller
                                                    .hireDriverStatusTab
                                                    .value ==
                                                RideDriverTabStatus.cancelled,
                                            onTap: () {
                                              controller.onTabTap(
                                                  RideDriverTabStatus
                                                      .cancelled);
                                            },
                                          ),
                                        ],
                                      ),
                                    )))),
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap15,
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        Obx(() {
                          switch (controller.hireDriverStatusTab.value) {
                            case RideDriverTabStatus.driverPending:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hiredDriverDetailsScreen,
                                          arguments:
                                              hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                            case RideDriverTabStatus.userPending:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hiredDriverDetailsScreen,
                                          arguments:
                                              hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                            case RideDriverTabStatus.accepted:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hiredDriverDetailsScreen,
                                          arguments:
                                              hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                            case RideDriverTabStatus.started:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hireDriverStartScreen,
                                          arguments:
                                              hireDriverListItemPending.id);

                                      // Get.toNamed(
                                      //     AppPageNames.hiredDriverDetailsScreen,
                                      //     arguments: hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                            case RideDriverTabStatus.completed:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hireDriverStartScreen,
                                          arguments:
                                              hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                            case RideDriverTabStatus.cancelled:
                              return PagedSliverList.separated(
                                pagingController:
                                    controller.hireDriverPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        HireDriverListItem>(
                                    noItemsFoundIndicatorBuilder: (context) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      EmptyScreenWidget(
                                        height: 110,
                                        isSVGImage: true,
                                        localImageAssetURL: AppAssetImages
                                            .officeDarkSVGLogoSolid,
                                        title: AppLanguageTranslation
                                            .noVehicleTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .addVehicleTransKey
                                            .toCurrentLanguage,
                                      ),
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final HireDriverListItem
                                      hireDriverListItemPending = item;

                                  return HireDriverListItemWidget(
                                    onTap: () {
                                      Get.toNamed(
                                          AppPageNames.hiredDriverDetailsScreen,
                                          arguments:
                                              hireDriverListItemPending.id);
                                    },
                                    rate: hireDriverListItemPending.amount,
                                    driverImage:
                                        hireDriverListItemPending.driver.image,
                                    driverName:
                                        hireDriverListItemPending.driver.name,
                                    rateType: hireDriverListItemPending.type,
                                    startAddress:
                                        hireDriverListItemPending.pickup,
                                    startDate:
                                        Helper.ddMMMyyyyFormattedDateTime(
                                            hireDriverListItemPending
                                                .start.date),
                                    startTime: Helper.hhMMaFormattedDate(
                                        hireDriverListItemPending.start.time),
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              );
                          }
                        }),
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap80,
                        ),
                        /* SliverList.separated(
                        itemCount: FakeData.hireDriverList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final FakeHireDriverList hireDriver =
                              FakeData.hireDriverList[index];
                          return HireDriverListItemWidget(
                            onTap: () {
                              Get.toNamed(AppPageNames.hiredDriverDetailsScreen,
                                  arguments: hireDriver);
                            },
                            status: 'upcoming',
                            rate: hireDriver.rate,
                            driverExperience: hireDriver.experience,
                            driverImage: hireDriver.image,
                            driverName: hireDriver.driverName,
                            driverRides: hireDriver.rideNumber,
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap15) */
                      ]),
                    ),
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    onPressed: () {
                      Get.toNamed(AppPageNames.addHireDriverScreen);
                    },
                    label: Text(
                        AppLanguageTranslation
                            .hireDriverTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: Colors.white)),
                    icon: const Icon(Icons.add, color: Colors.white),
                  )),
            ));
  }
}
