import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class RentCarListItemWidget extends StatelessWidget {
  final String carName;
  final String carCategoryName;
  final String carImage;
  final String fuelType;
  final String gearType;
  final String address;
  final int seat;
  final double review;
  final bool isMonthlySelected;
  final bool isWeeklySelected;
  final bool isHourlySelected;
  final double hourlyRate;
  final double monthlyRate;
  final double weeklyRate;
  final void Function()? onTap;
  final void Function()? onHourlyTap;
  final void Function()? onWeeklyTap;
  final void Function()? onMonthlyTap;

  const RentCarListItemWidget(
      {super.key,
      required this.carName,
      required this.carImage,
      this.onTap,
      required this.carCategoryName,
      required this.review,
      this.isMonthlySelected = false,
      this.isWeeklySelected = false,
      this.isHourlySelected = false,
      this.onHourlyTap,
      this.onWeeklyTap,
      this.onMonthlyTap,
      required this.hourlyRate,
      required this.monthlyRate,
      required this.weeklyRate,
      required this.fuelType,
      required this.gearType,
      required this.seat,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 230,
        width: 185,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap8,
            Text(
              carName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyLargeMediumTextStyle,
            ),
            AppGaps.hGap2,
            Text(
              carCategoryName,
              style: AppTextStyles.bodySmallMediumTextStyle
                  .copyWith(color: AppColors.bodyTextColor),
            ),
            AppGaps.hGap10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 75,
                  width: 95,
                  child: CachedNetworkImageWidget(
                    imageURL: carImage,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill)),
                    ),
                  ),
                ),
                AppGaps.wGap10,
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SvgPictureAssetWidget(
                            AppAssetImages.fuelTypeSVGLogoLine,
                            height: 14,
                            width: 14,
                            color: AppColors.bodyTextColor,
                          ),
                          AppGaps.wGap4,
                          Expanded(
                            child: Text(
                              fuelType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.captionMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap4,
                      Row(
                        children: [
                          const SvgPictureAssetWidget(
                            AppAssetImages.gearTypeSVGLogoLine,
                            height: 14,
                            width: 14,
                            color: AppColors.bodyTextColor,
                          ),
                          AppGaps.wGap4,
                          Expanded(
                            child: Text(
                              gearType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.captionMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                          ),
                        ],
                      ),
                      AppGaps.hGap4,
                      Row(
                        children: [
                          const SvgPictureAssetWidget(
                            AppAssetImages.seatSVGLogoLine,
                            height: 14,
                            width: 14,
                            color: AppColors.bodyTextColor,
                          ),
                          AppGaps.wGap4,
                          Expanded(
                            child: Text(
                              '$seat Seat',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.captionMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            AppGaps.hGap10,
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPictureAssetWidget(
                        AppAssetImages.locateSVGLogoLine,
                        height: 7,
                        width: 7,
                      ),
                      AppGaps.wGap4,
                      Expanded(
                          child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallestMediumTextStyle,
                      ))
                    ],
                  ),
                ),
                SingleStarWidget(review: review),
              ],
            ),
            AppGaps.hGap6,
            const Divider(
              thickness: 1,
              color: AppColors.primaryBorderColor,
            ),
            AppGaps.hGap6,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isHourlySelected && !isMonthlySelected && !isWeeklySelected
                    ? Expanded(
                        child: Text(
                            Helper.getCurrencyFormattedWithDecimalAmountText(
                                hourlyRate)),
                      )
                    : (isHourlySelected
                        ? Expanded(
                            child: Text(Helper
                                .getCurrencyFormattedWithDecimalAmountText(
                                    hourlyRate)),
                          )
                        : (isWeeklySelected
                            ? Expanded(
                                child: Text(Helper
                                    .getCurrencyFormattedWithDecimalAmountText(
                                        weeklyRate)),
                              )
                            : Expanded(
                                child: Text(Helper
                                    .getCurrencyFormattedWithDecimalAmountText(
                                        monthlyRate)),
                              ))),
              ],
            ),
            AppGaps.hGap4,
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    height: 25,
                    width: 125,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F6FA),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: onHourlyTap,
                            child: Text(
                                AppLanguageTranslation
                                    .hourlyTransKey.toCurrentLanguage,
                                style: isHourlySelected
                                    ? AppTextStyles.captionTextStyle.copyWith(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline)
                                    : AppTextStyles.captionTextStyle.copyWith(
                                        color: Colors.black,
                                      )),
                          ),
                          AppGaps.wGap2,
                          const Text(
                            '|',
                            style: AppTextStyles.smallestTextStyle,
                          ),
                          AppGaps.wGap2,
                          GestureDetector(
                              onTap: onWeeklyTap,
                              child: Text(
                                  AppLanguageTranslation
                                      .weeklyTransKey.toCurrentLanguage,
                                  style: isWeeklySelected
                                      ? AppTextStyles.captionTextStyle.copyWith(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline)
                                      : AppTextStyles.captionTextStyle.copyWith(
                                          color: Colors.black,
                                        ))),
                          AppGaps.wGap2,
                          const Text(
                            '|',
                            style: AppTextStyles.smallestTextStyle,
                          ),
                          AppGaps.wGap5,
                          GestureDetector(
                            onTap: onMonthlyTap,
                            child: Text(
                                AppLanguageTranslation
                                    .monthlyTransKey.toCurrentLanguage,
                                style: isMonthlySelected
                                    ? AppTextStyles.captionTextStyle.copyWith(
                                        color: AppColors.primaryColor,
                                        decoration: TextDecoration.underline)
                                    : AppTextStyles.captionTextStyle.copyWith(
                                        color: Colors.black,
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
