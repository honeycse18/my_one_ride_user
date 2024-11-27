import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/hired_driver_details_screen_controller.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class HiredDriverDetailsScreen extends StatelessWidget {
  const HiredDriverDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HireDriverDetailsScreenController>(
        global: false,
        init: HireDriverDetailsScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: Text(controller.hiredDriverDetails.driver.name)),
              body: ScaffoldBodyWidget(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppGaps.hGap10,
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(20),
                          height: 87,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 48,
                                width: 48,
                                child: CachedNetworkImageWidget(
                                  imageURL: controller
                                      .hiredDriverDetails.driver.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        /* borderRadius: AppComponents.imageBorderRadius, */
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              AppGaps.wGap10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.hiredDriverDetails.driver.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle,
                                    ),
                                    AppGaps.hGap10,
                                    const Row(
                                      children: [
                                        SingleStarWidget(review: 2),
                                        AppGaps.wGap5,
                                        Text(
                                          '(531 reviews)',
                                          style: AppTextStyles
                                              .smallestMediumTextStyle,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AppGaps.wGap10,
                              Row(
                                children: [
                                  Text(
                                    controller
                                        .hiredDriverDetails.currency.symbol,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                  AppGaps.wGap2,
                                  Text(
                                    controller.hiredDriverDetails.amount
                                        .toStringAsFixed(2),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    AppGaps.hGap10,
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.primaryBorderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: const Center(
                              child: RawButtonWidget(
                                  child: SvgPictureAssetWidget(
                                      AppAssetImages.callingSVGLogoSolid))),
                        ),
                        AppGaps.wGap8,
                        Expanded(
                            child: CustomMessageTextFormField(
                          onTap: () {
                            Get.toNamed(AppPageNames.chatScreen,
                                arguments:
                                    controller.hiredDriverDetails.driver.id);
                          },
                          isReadOnly: true,
                          suffixIcon: const SvgPictureAssetWidget(
                              AppAssetImages.sendSVGLogoLine),
                          boxHeight: 55,
                          hintText: AppLanguageTranslation
                              .messageYourDriverTransKey.toCurrentLanguage,
                        ))
                      ],
                    ),
                    /* AppGaps.hGap14,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              AppGaps.hGap10,
                              const Text(
                                '5 Years experience  ||  100+ Rides',
                                style: AppTextStyles.smallestTextStyle,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(14))),
                                    child: const Center(
                                        child: SvgPictureAssetWidget(
                                            AppAssetImages.timeDialogSvgIcon)),
                                  ),
                                  AppGaps.wGap16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${controller.isDays.inDays}',
                                        style: AppTextStyles
                                            .titleSemiSmallBoldTextStyle,
                                      ),
                                      const Text(
                                        'Days',
                                        style: AppTextStyles.bodyLargeTextStyle,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              AppGaps.hGap20,
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(14))),
                                    child: const Center(
                                        child: SvgPictureAssetWidget(
                                            AppAssetImages
                                                .dollerDialogSvgIcon)),
                                  ),
                                  AppGaps.wGap16,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Helper
                                            .getCurrencyFormattedWithDecimalAmountText(
                                                controller
                                                    .hiredDriverDetails.amount),
                                        style: AppTextStyles
                                            .titleSemiSmallBoldTextStyle,
                                      ),
                                      Text(
                                        'Total Fare',
                                        style: AppTextStyles.bodyLargeTextStyle,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ), */
                    AppGaps.hGap10,
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 108,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLanguageTranslation
                                          .startDateTransKey.toCurrentLanguage,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                    AppGaps.hGap6,
                                    Row(
                                      children: [
                                        const SvgPictureAssetWidget(
                                            AppAssetImages.calenderSVGLogoLine),
                                        AppGaps.wGap12,
                                        Text(Helper.ddMMMyyyyFormattedDateTime(
                                            controller
                                                .hiredDriverDetails.start.date))
                                      ],
                                    ),
                                    AppGaps.hGap6,
                                    Row(
                                      children: [
                                        const SvgPictureAssetWidget(
                                            AppAssetImages.clock),
                                        AppGaps.wGap12,
                                        Text(Helper.hhmmFormattedDateTime(
                                            controller
                                                .hiredDriverDetails.start.time))
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLanguageTranslation
                                          .endDateTransKey.toCurrentLanguage,
                                      style: AppTextStyles
                                          .bodyLargeSemiboldTextStyle
                                          .copyWith(
                                              color: AppColors.bodyTextColor),
                                    ),
                                    AppGaps.hGap6,
                                    Row(
                                      children: [
                                        const SvgPictureAssetWidget(
                                            AppAssetImages.calenderSVGLogoLine),
                                        AppGaps.wGap12,
                                        Text(Helper.ddMMMyyyyFormattedDateTime(
                                            controller
                                                .hiredDriverDetails.end.date))
                                      ],
                                    ),
                                    AppGaps.hGap6,
                                    Row(
                                      children: [
                                        const SvgPictureAssetWidget(
                                            AppAssetImages.clock),
                                        AppGaps.wGap12,
                                        Text(Helper.hhmmFormattedDateTime(
                                            controller
                                                .hiredDriverDetails.end.time))
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                        ))
                      ],
                    ),
                    AppGaps.hGap16,
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.all(15),
                          height: 95,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(18)),
                              border: Border.all(
                                  color: AppColors.primaryBorderColor)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .pickUpTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodySmallTextStyle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              AppGaps.hGap8,
                              Row(children: [
                                Image.asset(
                                  AppAssetImages.pickupMarkerPngIcon,
                                  height: 20,
                                  width: 20,
                                  color: AppColors.darkColor,
                                ),
                                AppGaps.wGap8,
                                Expanded(
                                  child: Text(
                                    controller.hiredDriverDetails.pickup,
                                    style: AppTextStyles.bodyLargeTextStyle
                                        .copyWith(
                                            color: AppColors.bodyTextColor),
                                  ),
                                )
                              ]),
                            ],
                          ),
                        )),
                      ],
                    ),
                    AppGaps.hGap16,
                    if (controller.hiredDriverDetails.status == 'accepted')
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 75,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18)),
                                  border: Border.all(
                                      color: AppColors.primaryBorderColor)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'OTP',
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                  Text(
                                    controller.hiredDriverDetails.otp,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    AppGaps.hGap100,
                    if (controller.hiredDriverDetails.status == 'user_pending')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLanguageTranslation
                                .fareDetailsTransKey.toCurrentLanguage,
                            style:
                                AppTextStyles.titleSemiSmallSemiboldTextStyle,
                          ),
                          AppGaps.hGap8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLanguageTranslation
                                    .fareTransKey.toCurrentLanguage,
                                style: AppTextStyles.bodyLargeTextStyle
                                    .copyWith(color: AppColors.bodyTextColor),
                              ),
                              Row(
                                children: [
                                  Text(
                                    controller
                                        .hiredDriverDetails.currency.symbol,
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                  AppGaps.wGap2,
                                  Text(
                                    controller.hiredDriverDetails.amount
                                        .toStringAsFixed(2),
                                    style: AppTextStyles
                                        .bodyLargeSemiboldTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          AppGaps.hGap15,
                          Text(
                              AppLanguageTranslation
                                  .riseFareTransKey.toCurrentLanguage,
                              style: AppTextStyles.bodyLargeMediumTextStyle),
                          AppGaps.hGap10,
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 62,
                                  width: 179,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18))),
                                  child: PlusMinusCounterRow(
                                      isDecrement: controller.rate.value > 10
                                          ? true
                                          : false,
                                      onRemoveTap: controller.onRemoveTap,
                                      counterText:
                                          controller.rate.value.toString(),
                                      onAddTap: controller.onAddTap),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ],
                ),
              )),
              bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.mainBg,
                  child: controller.hiredDriverDetails.status == 'user_pending'
                      ? Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              controller.rate.value ==
                                      controller.hiredDriverDetails.amount
                                  ? Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:
                                                CustomStretchedOnlyTextButtonWidget(
                                              buttonText: AppLanguageTranslation
                                                  .rejectTransKey
                                                  .toCurrentLanguage,
                                              onTap: controller.rejectRequest,
                                            ),
                                          ),
                                          Expanded(
                                              child:
                                                  CustomStretchedTextButtonWidget(
                                            buttonText: AppLanguageTranslation
                                                .acceptTransKey
                                                .toCurrentLanguage,
                                            onTap: controller.acceptRequest,
                                          ))
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child:
                                                CustomStretchedOnlyTextButtonWidget(
                                              buttonText: AppLanguageTranslation
                                                  .rejectTransKey
                                                  .toCurrentLanguage,
                                              onTap: controller.rejectRequest,
                                            ),
                                          ),
                                          Expanded(
                                              child:
                                                  CustomStretchedTextButtonWidget(
                                            buttonText: AppLanguageTranslation
                                                .updatePriceTransKey
                                                .toCurrentLanguage,
                                            onTap: controller.updateRequest,
                                          ))
                                        ],
                                      ),
                                    )
                            ],
                          ))
                      : /* controller.hiredDriverDetails.status ==
                                  'user_pending' ||
                              controller.hiredDriverDetails.status ==
                                  'driver_pending'
                          ? CustomStretchedTextButtonWidget(
                              buttonText: 'Cancel Hiring',
                              onTap: controller.rejectRequest,
                            )
                          :  */
                      controller.hiredDriverDetails.status == 'completed'
                          ? CustomStretchedTextButtonWidget(
                              buttonText: 'Payment', onTap: () {})

                          /* ? CustomStretchedTextButtonWidget(
                                  buttonText: 'Review Driver',
                                  onTap: controller.reviewDriver,
                                ) */
                          : AppGaps.emptyGap),

              /* bottomNavigationBar: CustomScaffoldBottomBarWidget(
                  backgroundColor: AppColors.mainBg,
                  child: /* controller.hiredDriverDetails.status ==
                              'driver_pending' || */
                      controller.hiredDriverDetails.status == 'user_pending'
                          ? Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  controller.rate.value ==
                                          controller.hiredDriverDetails.amount
                                      ? Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:
                                                    CustomStretchedOnlyTextButtonWidget(
                                                  buttonText:
                                                      AppLanguageTranslation
                                                          .rejectTransKey
                                                          .toCurrentLanguage,
                                                  onTap:
                                                      controller.rejectRequest,
                                                ),
                                              ),
                                              Expanded(
                                                  child:
                                                      CustomStretchedTextButtonWidget(
                                                buttonText:
                                                    AppLanguageTranslation
                                                        .acceptTransKey
                                                        .toCurrentLanguage,
                                                onTap: controller.acceptRequest,
                                              ))
                                            ],
                                          ),
                                        )
                                      : Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child:
                                                    CustomStretchedOnlyTextButtonWidget(
                                                  buttonText:
                                                      AppLanguageTranslation
                                                          .rejectTransKey
                                                          .toCurrentLanguage,
                                                  onTap:
                                                      controller.rejectRequest,
                                                ),
                                              ),
                                              Expanded(
                                                  child:
                                                      CustomStretchedTextButtonWidget(
                                                buttonText:
                                                    AppLanguageTranslation
                                                        .updatePriceTransKey
                                                        .toCurrentLanguage,
                                                onTap: controller.updateRequest,
                                              ))
                                            ],
                                          ),
                                        )
                                ],
                              ))
                          : controller.hiredDriverDetails.status ==
                                      'user_pending' ||
                                  controller.hiredDriverDetails.status ==
                                      'driver_pending'
                              ? CustomStretchedTextButtonWidget(
                                  buttonText: 'Cancel Hiring',
                                  onTap: controller.rejectRequest,
                                )
                              : controller.hiredDriverDetails.status ==
                                      'completed'
                                  ? CustomStretchedTextButtonWidget(
                                      buttonText: AppLanguageTranslation
                                          .paymentTransKey.toCurrentLanguage,
                                      onTap: () {
                                        Get.toNamed(
                                            AppPageNames
                                                .hireDriverSelectPaymentMethodsScreen,
                                            arguments: controller
                                                .hiredDriverDetails.id);
                                      },
                                    )
                                  /* ? CustomStretchedTextButtonWidget(
                                  buttonText: 'Review Driver',
                                  onTap: controller.reviewDriver,
                                ) */
                                  : AppGaps
                                      .emptyGap /* CustomStretchedTextButtonWidget(
                          buttonText: 'Cancel Hiring',
                          onTap: controller.rejectRequest,
                        ) */
                  ),
             */
            ));
  }
}
