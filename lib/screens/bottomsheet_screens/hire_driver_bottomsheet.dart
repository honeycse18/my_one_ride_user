// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/bottom_sheet_controller/hire_driver_bottom_sheet_controller.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/models/location_model.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/Tab_list_screen_widget.dart';

class HireDriverBottomSheet extends StatelessWidget {
  const HireDriverBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverBottomSheetScreenController>(
        global: false,
        init: HireDriverBottomSheetScreenController(),
        builder: (controller) => SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                /* controller.focusSearchDriver.hasFocus
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height * 0.4, */
                padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
                decoration: const BoxDecoration(
                    color: AppColors.mainBg,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawButtonWidget(
                          borderRadiusValue: 14,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: const Center(
                              child: SvgPictureAssetWidget(
                                AppAssetImages.arrowLeftSVGLogoLine,
                                color: AppColors.darkColor,
                                height: 18,
                                width: 18,
                              ),
                            ),
                          ),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        Text(
                          controller.hireDriver.name,
                          style: AppTextStyles.titleBoldTextStyle,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 40,
                          width: 40,
                        ),
                      ],
                    ),
                    AppGaps.hGap25,
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.hireDriverStatus.value ==
                                  HireDriverStatus.fixed
                              ? LocationPickUpTextFormField(
                                  onTap: () async {
                                    dynamic pickUpLocationResult =
                                        await Get.toNamed(
                                            AppPageNames.selectLocation,
                                            preventDuplicates: false);
                                    if (pickUpLocationResult is LocationModel) {
                                      controller.selectedPickUpLocation =
                                          pickUpLocationResult;
                                      controller.pickUpLocationTextController
                                          .text = pickUpLocationResult.address;
                                    }
                                    controller.update();
                                  },
                                  isReadOnly: true,
                                  controller:
                                      controller.pickUpLocationTextController,
                                  hintText: AppLanguageTranslation
                                      .pickUpTransKey.toCurrentLanguage,
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.pickLocationSVGLogoLine),
                                )
                              : CustomTextFormField(
                                  onTap: () async {
                                    dynamic pickUpLocationResult =
                                        await Get.toNamed(
                                            AppPageNames.selectLocation,
                                            preventDuplicates: false);
                                    if (pickUpLocationResult is LocationModel) {
                                      controller.selectedPickUpLocation =
                                          pickUpLocationResult;
                                      controller.pickUpLocationTextController
                                          .text = pickUpLocationResult.address;
                                    }
                                    controller.update();
                                  },
                                  isReadOnly: true,
                                  controller:
                                      controller.pickUpLocationTextController,
                                  hintText: AppLanguageTranslation
                                      .pickUpTransKey.toCurrentLanguage,
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.pickLocationSVGLogoLine),
                                ),
                          controller.hireDriverStatus.value ==
                                  HireDriverStatus.fixed
                              ? LocationPickDownTextFormField(
                                  onTap: () async {
                                    dynamic dropLocationResult =
                                        await Get.toNamed(
                                            AppPageNames.selectLocation,
                                            preventDuplicates: false);
                                    if (dropLocationResult is LocationModel) {
                                      controller.selectedDropLocation =
                                          dropLocationResult;
                                      controller.dropLocationTextController
                                          .text = dropLocationResult.address;
                                    }
                                    controller.update();
                                  },
                                  isReadOnly: true,
                                  controller:
                                      controller.dropLocationTextController,
                                  hintText: AppLanguageTranslation
                                      .dropLocTransKey.toCurrentLanguage,
                                  prefixIcon: const SvgPictureAssetWidget(
                                      AppAssetImages.solidLocationSVGLogoLine),
                                )
                              : AppGaps.emptyGap,
                          AppGaps.hGap24,
                          Text(
                            AppLanguageTranslation
                                .hireTypeTransKey.toCurrentLanguage,
                            style: AppTextStyles.bodyLargeMediumTextStyle,
                          ),
                          AppGaps.hGap8,
                          Obx(() => Row(
                                children: [
                                  TabStatusWidget(
                                    text: HireDriverStatus.hourly.viewableText,
                                    isSelected:
                                        controller.hireDriverStatus.value ==
                                            HireDriverStatus.hourly,
                                    onTap: () {
                                      controller.changeHireDriverStatusTab(
                                          HireDriverStatus.hourly);
                                    },
                                  ),
                                  AppGaps.wGap10,
                                  TabStatusWidget(
                                    text: HireDriverStatus.fixed.viewableText,
                                    isSelected:
                                        controller.hireDriverStatus.value ==
                                            HireDriverStatus.fixed,
                                    onTap: () {
                                      controller.changeHireDriverStatusTab(
                                          HireDriverStatus.fixed);
                                    },
                                  ),
                                ],
                              )),
                          AppGaps.hGap16,
                          Obx(
                            () => controller.hireDriverStatus.value ==
                                    HireDriverStatus.hourly
                                ? Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 62,
                                    width: 179,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: PlusMinusCounterRow(
                                        isDecrement: controller.rate.value > 30
                                            ? true
                                            : false,
                                        onRemoveTap: controller.onRemoveTap,
                                        counterText:
                                            controller.rate.value.toString(),
                                        onAddTap: controller.onAddTap),
                                  )
                                : SizedBox(
                                    width: 179,
                                    child: CustomTextFormField(
                                      controller:
                                          controller.fixedAmountTextController,
                                      prefixIcon: AppGaps.wGap15,
                                      hintText: r'$ Amount',
                                    )),
                          ),
                          AppGaps.hGap16,
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .startDateTimeTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .startDateTimeTransKey.toCurrentLanguage,
                            isReadOnly: true,
                            controller: TextEditingController(
                              text:
                                  '${DateFormat('dd/MM/yyyy').format(controller.selectedStartDate.value)}      ${controller.selectedStartTime.value.hourOfPeriod} : ${controller.selectedStartTime.value.minute} ${controller.selectedStartTime.value.period.name}',
                            ),
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.calenderSVGLogoLine),
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

                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                controller.updateSelectedStartTime(pickedTime);
                              }

                              controller.update();
                            },
                          ),
                          AppGaps.hGap24,
                          CustomTextFormField(
                            labelText: AppLanguageTranslation
                                .endDateTimeTransKey.toCurrentLanguage,
                            hintText: AppLanguageTranslation
                                .endDateTimeTransKey.toCurrentLanguage,
                            isReadOnly: true,
                            controller: TextEditingController(
                              text:
                                  '${DateFormat('dd/MM/yyyy').format(controller.selectedEndDate.value)}      ${controller.selectedEndTime.value.hourOfPeriod} : ${controller.selectedEndTime.value.minute} ${controller.selectedEndTime.value.period.name}',
                            ),
                            prefixIcon: const SvgPictureAssetWidget(
                                AppAssetImages.calenderSVGLogoLine),
                            onTap: () async {
                              DateTime? pickedEndDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 100),
                              );
                              if (pickedEndDate != null) {
                                controller.updateSelectedEndDate(pickedEndDate);
                              }

                              final TimeOfDay? pickedEndTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedEndTime != null) {
                                controller.updateSelectedEndTime(pickedEndTime);
                              }

                              controller.update();
                            },
                          ),
                          AppGaps.hGap24,
                        ],
                      ),
                    )),
                    Row(
                      children: [
                        RawButtonWidget(
                          child: Container(
                            height: 62,
                            width: 60,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18))),
                            child: const Center(
                              child: SvgPictureAssetWidget(
                                  AppAssetImages.chatMeSVGLogoLine),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(AppPageNames.chatScreen,
                                arguments: controller.hireDriver.id);
                          },
                        ),
                        AppGaps.wGap16,
                        Expanded(
                          child: CustomStretchedTextButtonWidget(
                            buttonText: AppLanguageTranslation
                                .hireTimeTransKey.toCurrentLanguage,
                            onTap: controller.toggleRentChanges,
                          ),
                        ),
                      ],
                    ),
                    AppGaps.hGap10,
                  ],
                ),
              ),
            ));
  }
}
