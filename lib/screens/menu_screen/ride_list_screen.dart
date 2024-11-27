import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/menu_screen_controller/ride_car_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

import 'package:one_ride_user/widgets/screen_widget/select_car_widget.dart';

class RideListCarScreen extends StatelessWidget {
  const RideListCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideCarScreenController>(
        global: false,
        init: RideCarScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(
                      AppLanguageTranslation.rideTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getNearestRidesList(
                      controller.passLatitude, controller.passLongitude);
                  controller.update();
                },
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    SliverToBoxAdapter(
                      child: SearchFilterRowWidget(
                          showFilter: true,
                          onSearchTap: () {
                            // Get.toNamed(AppPageNames.courseSubjectsScreen);
                          },
                          hintText: AppLanguageTranslation
                              .searchNameTransKey.toCurrentLanguage),
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                    SliverList.separated(
                      itemCount: controller.rides.length,
                      itemBuilder: (context, index) {
                        NearestCarsListRide ride = controller.rides[index];
                        return SelectHomeCarWidget(
                            onTap: () {
                              Helper.showTopSnackbarWithMessage(
                                'Please Login for hiring driver ',
                                onActionButtonTap: () {
                                  Get.toNamed(AppPageNames.logInScreen);
                                },
                              );
                            },
                            vehicleCategory: ride.vehicle.category.name,
                            fuelType: ride.vehicle.color,
                            seat: ride.vehicle.capacity,
                            carImage: ride.vehicle.images.firstOrNull ?? '',
                            amount: 0,
                            transportName: ride.vehicle.name,
                            distanceInTime: ride.driver.time.text);
                      },
                      separatorBuilder: (context, index) => AppGaps.hGap16,
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap15,
                    ),
                  ],
                ),
              )),
            ));
  }
}
