import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/rent_car_list_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/car_rent_response.dart';
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
import 'package:one_ride_user/widgets/screen_widget/Tab_list_screen_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/mytrip_ride_list_widget.dart';

class RentCarListScreen extends StatelessWidget {
  const RentCarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RentCarListScreenController>(
        global: false,
        init: RentCarListScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: const Text('Rent A Car')),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.rideTripPagingController.refresh(),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap10,
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            TabStatusWidget(
                              text:
                                  RideHistoryStatus.pending.stringValueForView,
                              isSelected: controller.rideTypeTab.value ==
                                  RideHistoryStatus.pending,
                              onTap: () {
                                controller
                                    .onRideTabTap(RideHistoryStatus.pending);
                              },
                            ),
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text:
                                  RideHistoryStatus.accepted.stringValueForView,
                              isSelected: controller.rideTypeTab.value ==
                                  RideHistoryStatus.accepted,
                              onTap: () {
                                controller
                                    .onRideTabTap(RideHistoryStatus.accepted);
                              },
                            ),
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text:
                                  RideHistoryStatus.started.stringValueForView,
                              isSelected: controller.rideTypeTab.value ==
                                  RideHistoryStatus.started,
                              onTap: () {
                                controller
                                    .onRideTabTap(RideHistoryStatus.started);
                              },
                            ),
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: RideHistoryStatus
                                  .completed.stringValueForView,
                              isSelected: controller.rideTypeTab.value ==
                                  RideHistoryStatus.completed,
                              onTap: () {
                                controller
                                    .onRideTabTap(RideHistoryStatus.completed);
                              },
                            ),
                            AppGaps.wGap10,
                            TabStatusWidget(
                              text: RideHistoryStatus
                                  .cancelled.stringValueForView,
                              isSelected: controller.rideTypeTab.value ==
                                  RideHistoryStatus.cancelled,
                              onTap: () {
                                controller
                                    .onRideTabTap(RideHistoryStatus.cancelled);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap24,
                    ),
                    Obx(() {
                      switch (controller.rideTypeTab.value) {
                        case RideHistoryStatus.pending:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideTripPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CarRentListItem>(
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
                                          .noRideHistoryTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final CarRentListItem carRentList = item;
                              return MyTripRideListWidget(
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: carRentList.owner.id);
                                },
                                dropLocation: carRentList.rent.address,
                                onTap: () {
                                  Get.toNamed(AppPageNames.carRentSummaryScreen,
                                      arguments: carRentList.id);
                                },
                                date: carRentList.date,
                                image: Helper.getFirstSafeString(
                                    carRentList.vehicle.images),
                                time: carRentList.date,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatus.accepted:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideTripPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CarRentListItem>(
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
                                          .noRideHistoryTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final CarRentListItem carRentList = item;
                              return MyTripRideListWidget(
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: carRentList.owner.id);
                                },
                                dropLocation: carRentList.rent.address,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.carRentListDetailsScreen,
                                      arguments: carRentList.id);
                                },
                                date: carRentList.date,
                                image: Helper.getFirstSafeString(
                                    carRentList.vehicle.images),
                                time: carRentList.date,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatus.started:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideTripPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CarRentListItem>(
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
                                          .noRideHistoryTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final CarRentListItem carRentList = item;
                              return MyTripRideListWidget(
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: carRentList.owner.id);
                                },
                                dropLocation: carRentList.rent.address,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.carRentListDetailsScreen,
                                      arguments: carRentList.id);
                                },
                                date: carRentList.date,
                                image: Helper.getFirstSafeString(
                                    carRentList.vehicle.images),
                                time: carRentList.date,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatus.completed:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideTripPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CarRentListItem>(
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
                                          .noRideHistoryTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final CarRentListItem carRentList = item;
                              return MyTripRideListWidget(
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: carRentList.owner.id);
                                },
                                dropLocation: carRentList.rent.address,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.carRentListDetailsScreen,
                                      arguments: carRentList.id);
                                },
                                date: carRentList.date,
                                image: Helper.getFirstSafeString(
                                    carRentList.vehicle.images),
                                time: carRentList.date,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatus.cancelled:
                          return PagedSliverList.separated(
                            pagingController:
                                controller.rideTripPagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<CarRentListItem>(
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
                                          .noRideHistoryTransKey
                                          .toCurrentLanguage,
                                      shortTitle: '')
                                ],
                              );
                            }, itemBuilder: (context, item, index) {
                              final CarRentListItem carRentList = item;
                              return MyTripRideListWidget(
                                onSendTap: () {
                                  Get.toNamed(AppPageNames.chatScreen,
                                      arguments: carRentList.owner.id);
                                },
                                dropLocation: carRentList.rent.address,
                                onTap: () {
                                  Get.toNamed(
                                      AppPageNames.carRentListDetailsScreen,
                                      arguments: carRentList.id);
                                },
                                date: carRentList.date,
                                image: Helper.getFirstSafeString(
                                    carRentList.vehicle.images),
                                time: carRentList.date,
                              );
                            }),
                            separatorBuilder: (context, index) =>
                                AppGaps.hGap16,
                          );
                        case RideHistoryStatus.unknown:
                          return const SliverToBoxAdapter(
                            child: Text('No Page Found'),
                          );
                      }
                    }),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap50,
                    ),
                  ],
                ),
              )),
              // floatingActionButton: FloatingActionButton.extended(
              //   shape: const RoundedRectangleBorder(
              //       borderRadius: BorderRadius.all(Radius.circular(14))),
              //   onPressed: () {
              //     Get.toNamed(AppPageNames.rentCarScreen);
              //   },
              //   label: Text('Rent A Car',
              //       style: AppTextStyles.bodyLargeSemiboldTextStyle
              //           .copyWith(color: Colors.white)),
              //   icon: const Icon(Icons.add, color: Colors.white),
              // ),
            ));
  }
}
