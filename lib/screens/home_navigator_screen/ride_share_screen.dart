import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/ride_share_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class RideShareScreen extends StatelessWidget {
  const RideShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideShareScreenController>(
      global: false,
      init: RideShareScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: CoreWidgets.appBarWidget(
            screenContext: context,
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.mainBg,
          body: Stack(
            children: [
              Positioned(
                  bottom: 50,
                  child: Image.asset(AppAssetImages.rideShareBackgroundImage)),
              Positioned.fill(
                  child: Opacity(
                opacity: 0.7,
                child: Container(color: Colors.black),
              )),
              Positioned.fill(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppGaps.hGap90,
                    if (Platform.isIOS) AppGaps.hGap40,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: controller.shareRideTabWidget(
                                isSelected: controller.isFindSelected,
                                title: AppLanguageTranslation
                                    .findRideTransKey.toCurrentLanguage,
                                onTap: () {
                                  if (!controller.isFindSelected) {
                                    controller.isFindSelected =
                                        !controller.isFindSelected;
                                    controller.update();
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: controller.shareRideTabWidget(
                                isSelected: !controller.isFindSelected,
                                title: AppLanguageTranslation
                                    .offerRideTransKey.toCurrentLanguage,
                                onTap: () {
                                  if (controller.isFindSelected) {
                                    controller.isFindSelected =
                                        !controller.isFindSelected;
                                    controller.update();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppGaps.hGap24,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: PickupAndDropLocationPickerWidget(
                        pickUpText: controller.pickUpLocation?.address ?? '',
                        dropText: controller.dropLocation?.address ?? '',
                        onPickUpTap: controller.onPickUpTap,
                        onDropTap: controller.onDropTap,
                      ),
                    ),
                    AppGaps.hGap24,
                    if (controller.isFindSelected)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 24),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              const SvgPictureAssetWidget(
                                  AppAssetImages.multiplePeopleSVGLogoLine),
                              AppGaps.wGap16,
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.seatSelected > 1) {
                                          controller.seatSelected -= 1;
                                          controller.update();
                                        }
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            color: AppColors.shadeColor1,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text("-",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.bodyTextColor)),
                                        ),
                                      ),
                                    ),
                                    Text(
                                        controller.seatSelected > 0
                                            ? '${controller.seatSelected.toString()} seat${controller.seatSelected > 1 ? "s" : ""}'
                                            : AppLanguageTranslation
                                                .availableTransKey
                                                .toCurrentLanguage,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.bodyTextColor)),
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.seatSelected < 15) {
                                          controller.seatSelected += 1;
                                          controller.update();
                                        }
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Center(
                                          child: Text("+",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (controller.isFindSelected) AppGaps.hGap24,
                    if (controller.isFindSelected)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CustomTextFormField(
                          hintText: AppLanguageTranslation
                              .startDateTransKey.toCurrentLanguage,
                          isReadOnly: true,
                          controller: TextEditingController(
                            text: DateFormat('yyyy-MM-dd').format(controller
                                .selectedStartDate
                                .value) /*      ${controller.selectedStartTime.value.hourOfPeriod} : ${controller.selectedStartTime.value.minute} ${controller.selectedStartTime.value.period.name} */,
                          ),
                          prefixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.calendar),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 100),
                            );
                            if (pickedDate != null) {
                              controller.updateSelectedStartDate(pickedDate);
                            }

                            /* final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              controller.updateSelectedStartTime(pickedTime);
                            } */

                            controller.update();
                          },
                        ),
                      )
                  ],
                ),
              ))
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 10.0),
                child: controller.isFindSelected
                    ? Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                      onPressed:
                                          controller.onFindPassengersButtonTap,
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor:
                                            AppColors.lineShapeColor,
                                        minimumSize: const Size(30, 62),
                                        side: BorderSide(color: Colors.white),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                          AppComponents.defaultBorderRadius,
                                        )),
                                      ),
                                      child: Center(
                                        child: Text(AppLanguageTranslation
                                            .findPassengerTransKey
                                            .toCurrentLanguage),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          AppGaps.wGap16,
                          Expanded(
                              child: StretchedTextButtonWidget(
                            buttonText: AppLanguageTranslation
                                .findCarTransKey.toCurrentLanguage,
                            onTap: (controller.pickUpLocation?.address == '' &&
                                    controller.dropLocation?.address == '')
                                ? () {
                                    APIHelper.onFailure(
                                        'Please Enter Both Location');
                                  }
                                : controller.onFindCarButtonTap,
                          )),
                        ],
                      )
                    : StretchedTextButtonWidget(
                        buttonText: AppLanguageTranslation
                            .nextTransKey.toCurrentLanguage,
                        onTap: controller.onNextButtonTap,
                      ),
              ),
              Container(
                color: Colors.black.withOpacity(0.7),
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
