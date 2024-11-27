import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:one_ride_user/controller/add_location_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AddLocationScreen extends StatelessWidget {
  const AddLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddLocationScreenController>(
        global: false,
        init: AddLocationScreenController(),
        builder: ((controller) => Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  hasBackButton: true,
                  screenContext: context,
                  titleWidget: Text(controller.locationID.isEmpty
                      ? AppLanguageTranslation
                          .adLocationTransKey.toCurrentLanguage
                      : AppLanguageTranslation
                          .updateLocationTransKey.toCurrentLanguage)),
              body: Stack(children: [
                Positioned.fill(
                    bottom: MediaQuery.of(context).size.height * 0.35,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                      compassEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: controller.cameraPosition,
                          zoom: controller.zoomLevel),
                      markers: controller.googleMapMarkers,
                      onMapCreated: controller.onGoogleMapCreated,
                    )),
                SlidingUpPanel(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  backdropEnabled: false,
                  maxHeight: controller.othersClicked ? 500 : 400,
                  minHeight: 400,
                  panel: Container(
                    padding: const EdgeInsets.all(24.0),
                    // padding: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppGaps.hGap10,
                        CustomTextFormField(
                          onTap: controller.onLocationTap,
                          isReadOnly: true,
                          labelText: AppLanguageTranslation
                              .locationTransKey.toCurrentLanguage,
                          hintText: controller.savedLocationScreenParameter
                                  .locationModel.address.isEmpty
                              ? AppLanguageTranslation
                                  .selectLocationTransKey.toCurrentLanguage
                              : controller.savedLocationScreenParameter
                                  .locationModel.address,
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.cossSVGIcon),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16.0),
                          child: Text(
                            AppLanguageTranslation
                                .saveAddressTransKey.toCurrentLanguage,
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: controller.saveAsOptions
                              .mapIndexed(
                                (index, singleOption) => GestureDetector(
                                  onTap: () => controller.onOptionTap(index),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Container(
                                          height: 78,
                                          width: 110,
                                          decoration: BoxDecoration(
                                              color: singleOption ==
                                                      controller
                                                          .selectedSaveAsOption
                                                  ? AppColors.primaryColor
                                                  : AppColors.shadeColor1,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 36, bottom: 16),
                                            child: Center(
                                              child: Text(
                                                singleOption.name,
                                                style: TextStyle(
                                                    color: singleOption ==
                                                            controller
                                                                .selectedSaveAsOption
                                                        ? Colors.white
                                                        : AppColors.darkColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: 35,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      offset:
                                                          const Offset(0, 10),
                                                      blurRadius: 25)
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Center(
                                              child: SvgPictureAssetWidget(
                                                singleOption.icon,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        if (controller.othersClicked) AppGaps.hGap25,
                        if (controller.othersClicked)
                          CustomTextFormField(
                            controller: controller.addressNameEditingController,
                            labelText: AppLanguageTranslation
                                .addressNameTransKey.toCurrentLanguage,
                            hintText: 'e.g: Shopping Mall',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                controller.addressNameEditingController.text =
                                    '';
                                controller.update();
                              },
                              child: const SvgPictureAssetWidget(
                                  AppAssetImages.cossSVGIcon),
                            ),
                          ),
                        AppGaps.hGap25,
                        StretchedTextButtonWidget(
                          buttonText: controller.locationID.isEmpty
                              ? AppLanguageTranslation
                                  .adLocationTransKey.toCurrentLanguage
                              : AppLanguageTranslation
                                  .updateLocationTransKey.toCurrentLanguage,
                          onTap: controller.buttonOkay &&
                                  controller.savedLocationScreenParameter
                                      .locationModel.address.isNotEmpty
                              ? controller.onAddLocationButtonTap
                              : null,
                        )
                      ],
                    ),
                  ),
                )
              ]),
            )));
  }
}
