import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/saved_locations_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/saved_location_list_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class SavedLocationsScreen extends StatelessWidget {
  const SavedLocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedLocationsScreenController>(
      global: false,
      init: SavedLocationsScreenController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.mainBg,
        appBar: CoreWidgets.appBarWidget(
            screenContext: context,
            hasBackButton: true,
            titleWidget: Text(AppLanguageTranslation
                .savedLocationTransKey.toCurrentLanguage)),
        body: RefreshIndicator(
          onRefresh: () async => controller.getSavedLocationList(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: CustomScrollView(
              slivers: [
                SliverList.separated(
                  itemBuilder: (context, index) {
                    SavedLocationListSingleLocation location =
                        controller.savedLocations[index];

                    List<String> icons = [
                      AppAssetImages.homeDarkSVGLogoSolid,
                      AppAssetImages.officeDarkSVGLogoSolid,
                      AppAssetImages.mallDarkSVGLogoSolid
                    ];
                    final String icon;
                    if (location.label == 'Home') {
                      icon = icons[0];
                    } else if (location.label == 'Office') {
                      icon = icons[1];
                    } else {
                      icon = icons[2];
                    }

                    ///Remover These later when API is ready    ----START
                    // List<String> titles = ['Home', 'Office', 'Shopping Mall'];
                    // List<String> types = ['home', 'office', 'other'];
                    // final String title = titles[index % 3];
                    // final String type = types[index % 3];

                    ///Remover These later when API is ready    ----END
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                      ),
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPictureAssetWidget(
                              icon,
                              height: 20,
                              width: 20,
                            ),
                            AppGaps.wGap12,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        location.label,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkColor),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () => controller
                                            .onDeleteButtonTap(location.id),
                                        child: const SvgPictureAssetWidget(
                                            AppAssetImages.trashSVGLogoSolid),
                                      ),
                                      AppGaps.wGap12,
                                      GestureDetector(
                                        onTap: () => controller
                                            .onEditLocationButtonTap(location),
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              AppLanguageTranslation
                                                  .editTransKey
                                                  .toCurrentLanguage,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            )),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    location.name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.bodyTextColor),
                                  ),
                                  Text(
                                    location.address,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.bodyTextColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.hGap24,
                  itemCount: controller.savedLocations.length,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: controller.onAddLocationButtonTap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(14)),
                child: Text(
                  AppLanguageTranslation.addLocationTransKey.toCurrentLanguage,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            AppGaps.hGap30
          ],
        ),
      ),
    );
  }
}
