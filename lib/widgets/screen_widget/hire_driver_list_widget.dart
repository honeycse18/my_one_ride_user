import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

import '../../utils/constants/app_components.dart';

class HireDriverListItemWidget extends StatelessWidget {
  final String driverName;
  final String driverImage;
  final String startAddress;
  final String startTime;
  final String startDate;
  final double rate;
  final String rateType;

  final void Function()? onTap;

  const HireDriverListItemWidget({
    super.key,
    required this.driverName,
    required this.startAddress,
    required this.rate,
    this.onTap,
    required this.driverImage,
    required this.startTime,
    required this.startDate,
    required this.rateType,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListTileWidget(
        onTap: onTap,
        hasShadow: true,
        paddingValue: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 85,
              width: 85,
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
                    const SvgPictureAssetWidget(
                      AppAssetImages.locateSVGLogoLine,
                      color: Colors.black,
                      height: 10,
                      width: 10,
                    ),
                    AppGaps.wGap4,
                    Expanded(
                      child: Text(
                        startAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmallMediumTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ),
                  ],
                ),
                AppGaps.hGap6,
                Text(
                  '${AppLanguageTranslation.startTransKey.toCurrentLanguage} : $startDate  $startTime',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallMediumTextStyle,
                ),
                AppGaps.hGap6,
                Row(
                  children: [
                    Text(
                      Helper.getCurrencyFormattedWithDecimalAmountText(rate),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle,
                    ),
                    AppGaps.wGap8,
                    Text(
                      rateType == 'hourly'
                          ? AppLanguageTranslation
                              .hourlyTransKey.toCurrentLanguage
                          : AppLanguageTranslation
                              .fixedTransKey.toCurrentLanguage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                  ],
                ),
              ],
            )),
          ],
        ));
  }
}
