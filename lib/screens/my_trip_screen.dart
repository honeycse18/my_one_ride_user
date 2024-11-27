import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/my_trip_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/ride_history_response.dart';
import 'package:one_ride_user/models/api_responses/share_ride_history_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/Tab_list_screen_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/ride_history_list_item_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/share_ride_list_item_widget.dart';

class MyTripScreen extends StatelessWidget {
  const MyTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyTripScreenController>(
        global: false,
        init: MyTripScreenController(),
        builder: (controller) => WillPopScope(
              onWillPop: () async {
                controller.popScope();
                return await Future.value(true);
              },
              child: Scaffold(
                backgroundColor: AppColors.mainBg,
                body: ScaffoldBodyWidget(
                    child: SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.isShareRideTabSelected.value
                          ? controller.shareRideHistoryPagingController
                              .refresh()
                          : controller.rideHistoryPagingController.refresh();
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* <---- Product Active Auctions tab button ----> */
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: 48,
                                      child: Obx(() =>
                                          CustomTabToggleButtonWidget(
                                              text: AppLanguageTranslation
                                                  .rideTransKey
                                                  .toCurrentLanguage,
                                              isSelected: !controller
                                                  .isShareRideTabSelected.value,
                                              onTap: () {
                                                controller
                                                    .isShareRideTabSelected
                                                    .value = false;
                                                controller.onRideTabTap(
                                                    RideHistoryStatus.accepted);
                                              })),
                                    ),
                                  ),
                                ),
                                AppGaps.wGap5,
                                /* <---- Product Won Auctions tab button ----> */
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      height: 48,
                                      child: Obx(() =>
                                          CustomTabToggleButtonWidget(
                                              text: AppLanguageTranslation
                                                  .shareRideTransKey
                                                  .toCurrentLanguage,
                                              isSelected: controller
                                                  .isShareRideTabSelected.value,
                                              onTap: () {
                                                controller
                                                    .isShareRideTabSelected
                                                    .value = true;
                                                controller.onShareRideTabTap(
                                                    ShareRideHistoryStatus
                                                        .findRide);
                                              })),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: AppGaps.hGap24),
                        Obx(() => !controller.isShareRideTabSelected.value
                            ? SliverToBoxAdapter(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      TabStatusWidget(
                                        text: RideHistoryStatus
                                            .accepted.stringValueForView,
                                        isSelected:
                                            controller.selectedStatus.value ==
                                                RideHistoryStatus.accepted,
                                        onTap: () {
                                          controller.onRideTabTap(
                                              RideHistoryStatus.accepted);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: RideHistoryStatus
                                            .started.stringValueForView,
                                        isSelected:
                                            controller.selectedStatus.value ==
                                                RideHistoryStatus.started,
                                        onTap: () {
                                          controller.onRideTabTap(
                                              RideHistoryStatus.started);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: RideHistoryStatus
                                            .completed.stringValueForView,
                                        isSelected:
                                            controller.selectedStatus.value ==
                                                RideHistoryStatus.completed,
                                        onTap: () {
                                          controller.onRideTabTap(
                                              RideHistoryStatus.completed);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: RideHistoryStatus
                                            .cancelled.stringValueForView,
                                        isSelected:
                                            controller.selectedStatus.value ==
                                                RideHistoryStatus.cancelled,
                                        onTap: () {
                                          controller.onRideTabTap(
                                              RideHistoryStatus.cancelled);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SliverToBoxAdapter(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .findRide.stringValueForView,
                                        isSelected:
                                            controller.shareRideTypeTab.value ==
                                                ShareRideHistoryStatus.findRide,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.findRide);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .offerRide.stringValueForView,
                                        isSelected: controller
                                                .shareRideTypeTab.value ==
                                            ShareRideHistoryStatus.offerRide,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.offerRide);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .accepted.stringValueForView,
                                        isSelected:
                                            controller.shareRideTypeTab.value ==
                                                ShareRideHistoryStatus.accepted,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.accepted);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .started.stringValueForView,
                                        isSelected:
                                            controller.shareRideTypeTab.value ==
                                                ShareRideHistoryStatus.started,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.started);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .completed.stringValueForView,
                                        isSelected: controller
                                                .shareRideTypeTab.value ==
                                            ShareRideHistoryStatus.completed,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.completed);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: ShareRideHistoryStatus
                                            .cancelled.stringValueForView,
                                        isSelected: controller
                                                .shareRideTypeTab.value ==
                                            ShareRideHistoryStatus.cancelled,
                                        onTap: () {
                                          controller.onShareRideTabTap(
                                              ShareRideHistoryStatus.cancelled);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap24,
                        ),
                        !controller.isShareRideTabSelected.value
                            ? PagedSliverList.separated(
                                pagingController:
                                    controller.rideHistoryPagingController,
                                builderDelegate:
                                    PagedChildBuilderDelegate<RideHistoryDoc>(
                                        noItemsFoundIndicatorBuilder:
                                            (context) {
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
                                              .noRideHistoryTransKey
                                              .toCurrentLanguage,
                                          shortTitle: '')
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  final RideHistoryDoc rideHistory = item;
                                  return RideHistoryListWidget(
                                    showCallChat: rideHistory.status ==
                                        RideHistoryStatus.accepted.stringValue,
                                    onSendTap: () {
                                      Get.toNamed(AppPageNames.chatScreen,
                                          arguments: rideHistory.driver.id);
                                    },
                                    pickupLocation: rideHistory.from.address,
                                    dropLocation: rideHistory.to.address,
                                    onTap: () =>
                                        controller.onRideWidgetTap(item),
                                    date: rideHistory.date,
                                    image: Helper.getFirstSafeString(
                                        rideHistory.ride.vehicle.images),
                                    time: rideHistory.date,
                                  );
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16,
                              )
                            : PagedSliverList.separated(
                                pagingController:
                                    controller.shareRideHistoryPagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                        ShareRideHistoryDoc>(
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
                                              .noShareRideHistoryTransKey
                                              .toCurrentLanguage,
                                          shortTitle: '')
                                    ],
                                  );
                                }, itemBuilder: (context, item, index) {
                                  ShareRideHistoryUser user = item.user;
                                  ShareRideHistoryFrom from = item.from;
                                  ShareRideHistoryTo to = item.to;
                                  DateTime date = item.date;
                                  String status =
                                      ShareRideAllStatus.toEnumValue(
                                              item.status)
                                          .stringValueForView;
                                  String id = item.id;
                                  int pending = item.pending;
                                  String type = item.type;
                                  if (item.offer.id.isNotEmpty) {
                                    // id = item.offer.id;
                                    user = item.offer.user;
                                    from = item.offer.from;
                                    to = item.offer.to;
                                    type = item.offer.type;
                                    date = item.offer.date;
                                  }
                                  return ShareRideListItemWidget(
                                      onTap: pending < 1
                                          ? () => controller.onShareRideItemTap(
                                              id, item, type)
                                          : () async {
                                              await controller
                                                  .onRequestButtonTap(id);
                                              controller
                                                  .shareRideHistoryPagingController
                                                  .refresh();
                                            },
                                      onRequestButtonTap:
                                          controller.selectedActionForRideShare
                                                          .value ==
                                                      ShareRideActions
                                                          .myOffer &&
                                                  item.pending > 0
                                              ? () async {
                                                  await controller
                                                      .onRequestButtonTap(id);
                                                  controller
                                                      .shareRideHistoryPagingController
                                                      .refresh();
                                                }
                                              : null,
                                      image: user.image,
                                      type: type,
                                      seats: item.seats,
                                      available: item.available,
                                      pickupLocation: from.address,
                                      dropLocation: to.address,
                                      time: date,
                                      date: date,
                                      status: status,
                                      showPending:
                                          controller.shareRideTypeTab.value ==
                                              ShareRideHistoryStatus.offerRide,
                                      pending: pending);
                                }),
                                separatorBuilder: (context, index) =>
                                    AppGaps.hGap16),
                        const SliverToBoxAdapter(
                          child: AppGaps.hGap24,
                        )
                      ],
                    ),
                  ),
                )),
              ),
            ));
  }
}
