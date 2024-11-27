import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/car_rent_bottomsheet_controller.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/Tab_list_screen_widget.dart';

class CarRentBookBottomSheet extends StatelessWidget {
  const CarRentBookBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarRentBottomSheetScreenController>(
        global: false,
        init: CarRentBottomSheetScreenController(),
        builder: (controller) => Container(
              padding: const EdgeInsets.all(24),
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                  color: AppColors.mainBg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: const Center(
                                child: SvgPictureAssetWidget(
                              AppAssetImages.arrowLeftSVGLogoLine,
                              color: Colors.black,
                            )),
                          ),
                          AppGaps.wGap56,
                          Expanded(
                            child: Text(
                              controller.carRentDetails.vehicle.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.titleBoldTextStyle,
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap27,
                      Text(
                        AppLanguageTranslation
                            .typeOfRentTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                      AppGaps.hGap10,
                      Obx(() => Row(
                            children: [
                              Expanded(
                                  child: TabStatusWidget(
                                text: RentCarStatusStatus
                                    .hourly.stringValueForView,
                                isSelected: controller.messageTypeTab.value ==
                                    RentCarStatusStatus.hourly,
                                onTap: () {
                                  controller
                                      .onTabTap(RentCarStatusStatus.hourly);
                                  controller.update();
                                },
                              )),
                              AppGaps.wGap10,
                              Expanded(
                                  child: TabStatusWidget(
                                text: RentCarStatusStatus
                                    .weekly.stringValueForView,
                                isSelected: controller.messageTypeTab.value ==
                                    RentCarStatusStatus.weekly,
                                onTap: () {
                                  controller
                                      .onTabTap(RentCarStatusStatus.weekly);
                                  controller.update();
                                },
                              )),
                              AppGaps.wGap10,
                              Expanded(
                                  child: TabStatusWidget(
                                text: RentCarStatusStatus
                                    .monthly.stringValueForView,
                                isSelected: controller.messageTypeTab.value ==
                                    RentCarStatusStatus.monthly,
                                onTap: () {
                                  controller
                                      .onTabTap(RentCarStatusStatus.monthly);
                                  controller.update();
                                },
                              )),
                            ],
                          )),
                      AppGaps.hGap16,
                      Container(
                          height: 62,
                          width: 175,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Center(
                              child: controller.messageTypeTab.value ==
                                      RentCarStatusStatus.hourly
                                  ? Text(
                                      '${Helper.getCurrencyFormattedWithDecimalAmountText(controller.carRentDetails.prices.hourly.price)} / Hour ')
                                  : controller.messageTypeTab.value ==
                                          RentCarStatusStatus.weekly
                                      ? Text(
                                          '${Helper.getCurrencyFormattedWithDecimalAmountText(controller.carRentDetails.prices.weekly.price)} / Week ')
                                      : Text(
                                          '${Helper.getCurrencyFormattedWithDecimalAmountText(controller.carRentDetails.prices.monthly.price)} / Month '))),
                      AppGaps.hGap16,
                      controller.messageTypeTab.value ==
                              RentCarStatusStatus.hourly
                          ? Text(
                              AppLanguageTranslation
                                  .hourTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyLargeSemiboldTextStyle,
                            )
                          : controller.messageTypeTab.value ==
                                  RentCarStatusStatus.weekly
                              ? Text(
                                  AppLanguageTranslation
                                      .weekTransKey.toCurrentLanguage,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                )
                              : Text(
                                  AppLanguageTranslation
                                      .monthTransKey.toCurrentLanguage,
                                  style:
                                      AppTextStyles.bodyLargeSemiboldTextStyle,
                                ),
                      AppGaps.hGap8,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 62,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              child: PlusMinusCounterRow(
                                  isDecrement: controller.amount.value > 1
                                      ? true
                                      : false,
                                  onRemoveTap: controller.onRemoveTap,
                                  counterText:
                                      controller.amount.value.toString(),
                                  onAddTap: controller.onAddTap),
                            ),
                          ),
                        ],
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

                          // ignore: use_build_context_synchronously
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
                      AppGaps.hGap20,
                      controller.messageTypeTab.value ==
                              RentCarStatusStatus.hourly
                          ? CustomStretchedButtonWidget(
                              onTap: controller.postRentRequest,
                              child: Text(
                                  ' ${AppLanguageTranslation.continueWithTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedWithDecimalAmountText(controller.hourlyCalTap)} '))
                          : controller.messageTypeTab.value ==
                                  RentCarStatusStatus.weekly
                              ? CustomStretchedButtonWidget(
                                  onTap: controller.postRentRequest,
                                  child: Text(
                                      ' ${AppLanguageTranslation.continueWithTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedWithDecimalAmountText(controller.weeklyCalTap)} '),
                                )
                              : CustomStretchedButtonWidget(
                                  onTap: controller.postRentRequest,
                                  child: Text(
                                      ' ${AppLanguageTranslation.continueWithTransKey.toCurrentLanguage} ${Helper.getCurrencyFormattedWithDecimalAmountText(controller.monthlyCalTap)} '))
                    ]),
              ),
            ));
  }
}
