import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class AddHireDriverListItemWidget extends StatelessWidget {
  final String driverName;
  final String driverImage;
  final String location;
  final int driverExperience;
  final int driverRides;
  final double rate;
  final double rating;
  final bool isOnTapNeed;

  final void Function()? onTap;
  final void Function()? onhireTap;

  AddHireDriverListItemWidget(
      {super.key,
      required this.driverName,
      required this.location,
      required this.rate,
      required this.rating,
      this.onTap,
      this.onhireTap,
      this.isOnTapNeed = false,
      required this.driverImage,
      required this.driverExperience,
      required this.driverRides});

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: isOnTapNeed ? onTap : null,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 82,
              width: 82,
              child: CachedNetworkImageWidget(
                imageURL: driverImage,
                imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.imageBorderRadius,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            AppGaps.wGap12,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle,
                ),
                AppGaps.hGap6,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '$driverExperience ${AppLanguageTranslation.yearsExperienceTransKey.toCurrentLanguage}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmallTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ),
                    AppGaps.wGap8,
                    Expanded(
                      child: SingleStarWidget(
                        review: rating,
                      ),
                    )
                  ],
                ),
                AppGaps.hGap6,
                Row(
                  children: [
                    const SvgPictureAssetWidget(
                      AppAssetImages.locateSVGLogoLine,
                      height: 10,
                      width: 10,
                    ),
                    AppGaps.wGap5,
                    Expanded(
                        child: Text(
                      location,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmallMediumTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ))
                  ],
                ),
                AppGaps.hGap6,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        Helper.getCurrencyFormattedWithDecimalAmountText(rate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle,
                      ),
                    ),
                    AppGaps.wGap8,
                    Expanded(
                      child: Text(
                        AppLanguageTranslation.hourlyTransKey.toCurrentLanguage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeSemiboldTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ),
                  ],
                )
              ],
            )),
            if (Helper.isUserLoggedIn())
              RawButtonWidget(
                  borderRadiusValue: 3,
                  onTap: isOnTapNeed ? onhireTap : null,
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      width: 40,
                      height: 25,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Center(
                        child: Text(
                          AppLanguageTranslation
                              .hireTimeTransKey.toCurrentLanguage,
                          style: AppTextStyles.bodyMediumTextStyle
                              .copyWith(color: Colors.white),
                        ),
                      ))),
            AppGaps.wGap8,
          ],
        ));
  }
}
