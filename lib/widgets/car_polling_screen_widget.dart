import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class CarPoolRequestWidget extends StatelessWidget {
  final String username;
  final String image;
  final double rate;
  final int seat;
  final String dropLocation;
  final String pickLocation;

  const CarPoolRequestWidget({
    super.key,
    required this.username,
    required this.rate,
    required this.seat,
    required this.dropLocation,
    required this.pickLocation,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 185,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: CachedNetworkImageWidget(
                  imageURL: image,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: AppComponents.imageBorderRadius,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                ),
              ),
              AppGaps.wGap8,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          username,
                          style: AppTextStyles.bodyLargeSemiboldTextStyle,
                        ),
                        AppGaps.wGap5,
                        if (seat > 1)
                          const Text(
                            '+',
                            style: AppTextStyles.bodyLargeSemiboldTextStyle,
                          ),
                        // if (seat > 1)
                        Expanded(
                          child: Row(
                            children: List.generate(6, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Container(
                                  width:
                                      19, // Adjust the size of the dot as needed
                                  height: 19,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        SingleStarWidget(review: 3),
                        AppGaps.wGap4,
                        Text(
                          '(531 Rides)',
                          style: AppTextStyles.bodySmallTextStyle,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '${Helper.getCurrencyFormattedWithDecimalAmountText(rate)} ',
                        style: AppTextStyles.bodySmallSemiboldTextStyle,
                      ),
                      Text(
                        ' / ${AppLanguageTranslation.perSeatTransKey.toCurrentLanguage}',
                        style: AppTextStyles.bodySmallSemiboldTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                    ],
                  ),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      const SvgPictureAssetWidget(
                        AppAssetImages.seat,
                        height: 10,
                        width: 10,
                      ),
                      Text(
                        '$seat  ${AppLanguageTranslation.seatTransKey.toCurrentLanguage}',
                        style: AppTextStyles.smallestSemiboldTextStyle,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          AppGaps.hGap12,
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
                      AppLanguageTranslation.pickUpTransKey.toCurrentLanguage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmallTextStyle
                          .copyWith(color: AppColors.bodyTextColor),
                    ),
                    AppGaps.hGap4,
                    Text(
                      pickLocation,
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
                      AppLanguageTranslation.dropLocTransKey.toCurrentLanguage,
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
          ),
        ],
      ),
    );
  }
}
