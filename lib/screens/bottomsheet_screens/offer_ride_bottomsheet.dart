import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/bottom_sheet_controller/offer-ride-bottom-sheet-controller.dart';
import 'package:one_ride_user/models/api_responses/all_categories_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class OfferRideBottomSheet extends StatelessWidget {
  const OfferRideBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferRideBottomSheetController>(
        global: false,
        init: OfferRideBottomSheetController(),
        builder: (controller) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: SingleChildScrollView(
                child: Container(
                  height:
                      controller.offerRideBottomSheetParameters.isCreateOffer
                          ? 706
                          : 550,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: AppColors.mainBg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TightIconButtonWidget(
                            onTap: () {
                              Get.back();
                            },
                            icon: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 25,
                                        offset: const Offset(0, 14))
                                  ]),
                              child: const Center(
                                  child: SvgPictureAssetWidget(
                                AppAssetImages.arrowLeftSVGLogoLine,
                                color: AppColors.darkColor,
                              )),
                            ),
                          ),
                          Expanded(
                            child: Center(
                                child: Text(
                              controller.offerRideBottomSheetParameters
                                      .isCreateOffer
                                  ? AppLanguageTranslation
                                      .createRideTransKey.toCurrentLanguage
                                  : AppLanguageTranslation
                                      .offerARideTransKey.toCurrentLanguage,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkColor),
                            )),
                          )
                        ],
                      ),
                      AppGaps.hGap24,
                      PickupAndDropLocationPickerWidget(
                          pickUpText: controller.offerRideBottomSheetParameters
                              .pickUpLocation.address,
                          dropText: controller.offerRideBottomSheetParameters
                              .dropLocation.address),
                      AppGaps.hGap16,
                      Container(
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
                                          : controller
                                                  .offerRideBottomSheetParameters
                                                  .isCreateOffer
                                              ? AppLanguageTranslation
                                                  .availableTransKey
                                                  .toCurrentLanguage
                                              : AppLanguageTranslation
                                                  .seatNeedTransKey
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
                      AppGaps.hGap16,
                      CustomTextFormField(
                        hintText: controller
                                .offerRideBottomSheetParameters.isCreateOffer
                            ? AppLanguageTranslation
                                .perSeatPriceTransKey.toCurrentLanguage
                            : AppLanguageTranslation
                                .budgetPerSeatTransKey.toCurrentLanguage,
                        textInputType: TextInputType.number,
                        controller: controller.seatPriceController,
                        prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.calendar),
                      ),
                      AppGaps.hGap16,
                      CustomTextFormField(
                        hintText: AppLanguageTranslation
                            .startDateTransKey.toCurrentLanguage,
                        isReadOnly: true,
                        controller: TextEditingController(
                          text:
                              '${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)}      ${controller.selectedTime.value.hourOfPeriod} : ${controller.selectedTime.value.minute} ${controller.selectedTime.value.period.name}',
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

                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            controller.updateSelectedStartTime(pickedTime);
                          }

                          controller.update();
                        },
                      ),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        DropdownButtonFormFieldWidget<AllCategoriesDoc>(
                            hintText: AppLanguageTranslation
                                .selectCategoryTransKey.toCurrentLanguage,
                            items: controller.categories,
                            getItemText: (p0) {
                              return p0.name;
                            },
                            onChanged: (value) {
                              controller.selectedCategory = value;
                              controller.update();
                            }),
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        AppGaps.hGap16,
                      if (controller
                          .offerRideBottomSheetParameters.isCreateOffer)
                        CustomTextFormField(
                          controller: controller.vehicleNumberController,
                          hintText: AppLanguageTranslation
                              .vehicleNumberTransKey.toCurrentLanguage,
                        ),
                      AppGaps.hGap21,
                      StretchedTextButtonWidget(
                          onTap: controller.onSubmitButtonTap,
                          buttonText: AppLanguageTranslation
                              .submitTransKey.toCurrentLanguage)
                    ],
                  ),
                ),
              ),
            ));
  }
}
