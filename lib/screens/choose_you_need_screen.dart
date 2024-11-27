import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/choose_you_need_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_pulling_requests_response.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ShareRideOverviewScreen extends StatelessWidget {
  const ShareRideOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseYouNeedScreenController>(
        global: false,
        init: ChooseYouNeedScreenController(),
        builder: ((controller) => Scaffold(
              appBar: CoreWidgets.appBarWidget(
                  appBarBackgroundColor: Colors.white,
                  screenContext: context,
                  hasBackButton: true,
                  titleWidget: Text(AppLanguageTranslation
                      .chooseYouNeedTransKey.toCurrentLanguage)),
              backgroundColor: AppColors.mainBg,
              body: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.dividerColor),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: PickupAndDropLocationPickerWidget(
                              pickUpText: controller.shareRideScreenParameter
                                      .pickUpLocation.address.isEmpty
                                  ? AppLanguageTranslation
                                      .noPickUpSelectedTransKey
                                      .toCurrentLanguage
                                  : controller.shareRideScreenParameter
                                      .pickUpLocation.address,
                              dropText: controller.shareRideScreenParameter
                                      .dropLocation.address.isEmpty
                                  ? AppLanguageTranslation
                                      .noDropSelectedTransKey.toCurrentLanguage
                                  : controller.shareRideScreenParameter
                                      .dropLocation.address,
                              isPickupEditable: false,
                              isDropEditable: false,
                              onPickupEditTap: controller.onPickupEditTap,
                              onDropEditTap: controller.onDropEditTap,
                            ),
                          ),
                          AppGaps.hGap15,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Helper.yyyyMMddFormattedDateTime(
                                    controller.shareRideScreenParameter.date),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                              Text(
                                '${controller.shareRideScreenParameter.totalSeat} seat${controller.shareRideScreenParameter.totalSeat > 1 ? "s" : ""}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          AppGaps.hGap15,
                        ],
                      ),
                    ),
                  ),
                  // AppGaps.hGap24,
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.nearestRequestPagingController.refresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: PagedListView.separated(
                          pagingController:
                              controller.nearestRequestPagingController,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          separatorBuilder: (context, index) => AppGaps.hGap24,
                          builderDelegate: CoreWidgets
                              .pagedChildBuilderDelegate<NearestRequestsDoc>(
                                  itemBuilder: (context, item, index) {
                            Random random = Random();
                            return SingleOfferItem(
                              onTap: () =>
                                  controller.onSingleRequestTap(item.id),
                              image: item.user.image,
                              name: item.user.name,
                              type: item.type,
                              pricePerSeat: item.rate.toDouble(),
                              rating: random.nextDouble() * 5,
                              totalRides: random.nextInt(500) + 10,
                              pickUpLocation: LocationModel(
                                  latitude: 0,
                                  longitude: 0,
                                  address: item.from.address),
                              dropLocation: LocationModel(
                                  latitude: 0,
                                  longitude: 0,
                                  address: item.to.address),
                              seatAvailable: item.available,
                              seatBooked: item.seats - item.available,
                              dateAndTime: item.date,
                            );
                          }),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
