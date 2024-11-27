import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class MyTripRideListWidget extends StatelessWidget {
  final String image;
  final String dropLocation;
  final DateTime time;
  final DateTime date;
  final void Function()? onTap;
  final void Function()? onSendTap;
  const MyTripRideListWidget({
    super.key,
    this.onTap,
    this.onSendTap,
    required this.image,
    required this.dropLocation,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(19),
            height: 225,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Helper.hhmmFormattedTime(time),
                            style: AppTextStyles.titleSemiSmallSemiboldTextStyle
                                .copyWith(color: AppColors.primaryColor),
                          ),
                          AppGaps.hGap4,
                          Text(
                            Helper.ddMMMyyyyFormattedDateTime(date),
                            style: AppTextStyles.bodyTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 66,
                      width: 66,
                      child: CachedNetworkImageWidget(
                        imageURL: image,
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
                  ],
                ),
                AppGaps.hGap8,
                Row(
                  children: [
                    /* RawButtonWidget(
                      borderRadiusValue: 12,
                      child: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            border: Border.all(
                                color: AppColors.primaryBorderColor)),
                        child: const Center(
                            child: SvgPictureAssetWidget(
                                AppAssetImages.callingSVGLogoSolid)),
                      ),
                      onTap: () {},
                    ),
                    AppGaps.wGap8, */
                    Expanded(
                        child: CustomMessageTextFormField(
                      onTap: onSendTap,
                      isReadOnly: true,
                      suffixIcon: const SvgPictureAssetWidget(
                          AppAssetImages.sendSVGLogoLine),
                      boxHeight: 55,
                      hintText: AppLanguageTranslation
                          .messageYourDriverTransKey.toCurrentLanguage,
                    ))
                  ],
                ),
                AppGaps.hGap16,
                Text(
                  AppLanguageTranslation
                      .carCollectionPointTransKey.toCurrentLanguage,
                  style: AppTextStyles.bodySmallTextStyle
                      .copyWith(color: AppColors.bodyTextColor),
                ),
                AppGaps.hGap4,
                Row(
                  children: [
                    const SvgPictureAssetWidget(
                      AppAssetImages.locateSVGLogoLine,
                      color: AppColors.primaryColor,
                    ),
                    AppGaps.wGap8,
                    Expanded(
                      child: Text(
                        dropLocation,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLargeMediumTextStyle,
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
