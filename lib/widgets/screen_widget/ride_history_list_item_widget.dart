import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class RideHistoryListWidget extends StatelessWidget {
  final String image;
  final String pickupLocation;
  final String dropLocation;
  final bool showCallChat;
  final DateTime time;
  final DateTime date;
  final void Function()? onTap;
  final void Function()? onSendTap;
  const RideHistoryListWidget({
    super.key,
    this.onTap,
    this.onSendTap,
    required this.image,
    required this.pickupLocation,
    required this.dropLocation,
    this.showCallChat = false,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.all(19),
            height: showCallChat ? 290 : 220,
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
                if (showCallChat) AppGaps.hGap8,
                if (showCallChat)
                  Row(
                    children: [
                      // RawButtonWidget(
                      //   borderRadiusValue: 12,
                      //   child: Container(
                      //     height: 55,
                      //     width: 55,
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //             const BorderRadius.all(Radius.circular(12)),
                      //         border: Border.all(
                      //             color: AppColors.primaryBorderColor)),
                      //     child: const Center(
                      //         child: SvgPictureAssetWidget(
                      //             AppAssetImages.callingSVGLogoSolid)),
                      //   ),
                      //   onTap: () {},
                      // ),
                      // AppGaps.wGap8,
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
                Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SvgPictureAssetWidget(
                        AppAssetImages.pickLocationSVGLogoLine,
                        height: 16,
                        width: 16,
                      ),
                      AppGaps.wGap4,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .pickUpTransKey.toCurrentLanguage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap4,
                            Text(
                              pickupLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SvgPictureAssetWidget(
                        AppAssetImages.solidLocationSVGLogoLine,
                        height: 16,
                        width: 16,
                      ),
                      AppGaps.wGap4,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLanguageTranslation
                                  .dropLocTransKey.toCurrentLanguage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmallTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                            AppGaps.hGap4,
                            Text(
                              dropLocation,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ]),
              ],
            )));
  }
}
