import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/menu_screen_controller/rent_car_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/car_rent_item_widget.dart';

class RentCarScreen extends StatelessWidget {
  const RentCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RentCarScreenController>(
        global: false,
        init: RentCarScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .rentCarTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.rentCarPagingController.refresh(),
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
                    PagedSliverGrid(
                      pagingController: controller.rentCarPagingController,
                      builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                              RentCarListItem>(
                          noItemFoundIndicatorBuilder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            EmptyScreenWidget(
                                isSVGImage: true,
                                localImageAssetURL:
                                    AppAssetImages.drivingSVGLogoLine,
                                title: AppLanguageTranslation
                                    .noDriverAddTransKey.toCurrentLanguage),
                          ],
                        );
                      }, itemBuilder: (context, item, index) {
                        final RentCarListItem rentCarList = item;
                        return RentCarListItemWidget(
                          address: rentCarList.address,
                          fuelType: rentCarList.vehicle.fuelType,
                          gearType: rentCarList.vehicle.gearType,
                          seat: rentCarList.vehicle.capacity,
                          onMonthlyTap: () {
                            rentCarList.isMonthlySelected = true;
                            rentCarList.isHourlySelected = false;
                            rentCarList.isWeeklySelected = false;

                            controller.update();
                          },
                          onWeeklyTap: () {
                            rentCarList.isHourlySelected = false;
                            rentCarList.isWeeklySelected = true;
                            rentCarList.isMonthlySelected = false;
                            controller.update();
                          },
                          onHourlyTap: () {
                            rentCarList.isHourlySelected = true;
                            rentCarList.isWeeklySelected = false;
                            rentCarList.isMonthlySelected = false;
                            controller.update();
                          },
                          hourlyRate: rentCarList.prices.hourly.price,
                          weeklyRate: rentCarList.prices.weekly.price,
                          monthlyRate: rentCarList.prices.monthly.price,
                          isHourlySelected: rentCarList.isHourlySelected,
                          isMonthlySelected: rentCarList.isMonthlySelected,
                          isWeeklySelected: rentCarList.isWeeklySelected,
                          review: 0.0,
                          onTap: () {
                            Get.toNamed(AppPageNames.carDetailsScreen,
                                arguments: rentCarList.id);
                          },
                          carImage: Helper.getFirstSafeString(
                              rentCarList.vehicle.images),
                          carName: rentCarList.vehicle.name,
                          carCategoryName: rentCarList.vehicle.category.name,
                        );
                      }),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 245,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                              crossAxisCount: 2),
                    ),
                  ],
                ),
              )),
            ));
  }
}
