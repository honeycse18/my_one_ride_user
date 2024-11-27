import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/menu_screen_controller/add_hire_driver_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/screens/bottomsheet_screens/hire_driver_bottomsheet.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/add_hire_driver_widgets.dart';

class AddHireDriverScreen extends StatelessWidget {
  const AddHireDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHireDriverScreenController>(
        global: false,
        init: AddHireDriverScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(AppLanguageTranslation
                      .hireDriverTransKey.toCurrentLanguage)),
              body: ScaffoldBodyWidget(
                  child: RefreshIndicator(
                onRefresh: () async =>
                    controller.nearestDriverPagingController.refresh(),
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
                    PagedSliverList.separated(
                      pagingController:
                          controller.nearestDriverPagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<NearestDriverList>(
                        noItemsFoundIndicatorBuilder: (context) {
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
                        },
                        itemBuilder: (context, item, index) {
                          final NearestDriverList nearestDriverList = item;
                          return AddHireDriverListItemWidget(
                            
                            isOnTapNeed: true,
                            driverExperience: 0,
                            driverImage: nearestDriverList.image,
                            driverName: nearestDriverList.name,
                            driverRides: 0,
                            location: nearestDriverList.address,
                            rate: nearestDriverList.rate,
                            rating: 0,
                            onhireTap: () {
                              Get.bottomSheet(HireDriverBottomSheet(),
                                  settings: RouteSettings(
                                      arguments: nearestDriverList),
                                  isScrollControlled: true,
                                  ignoreSafeArea: false);
                            },
                            onTap: () {
                              controller.witOutLogin
                                  ? Helper.showTopSnackbarWithMessage(
                                      'Please Login for hiring driver ',
                                      onActionButtonTap: () {
                                        Get.toNamed(AppPageNames.logInScreen);
                                      },
                                    )
                                  : Get.toNamed(
                                      AppPageNames.hireDriverDetailsScreen,
                                      arguments: nearestDriverList);
                            },
                          );
                        },
                      ),
                      separatorBuilder: (context, index) => AppGaps.hGap24,
                    ),
                    const SliverToBoxAdapter(
                      child: AppGaps.hGap26,
                    ),
                  ],
                ),
              )),
            ));
  }
}
