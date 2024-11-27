import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ChatListWidget extends StatelessWidget {
  final String name;
  final String image;
  final String message;
  final bool read;
  final bool mine;
  final DateTime datetime;
  final void Function()? onTap;

  const ChatListWidget({
    super.key,
    required this.name,
    required this.image,
    required this.message,
    required this.datetime,
    this.onTap,
    required this.read,
    required this.mine,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMessageListTileWidget(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          !read && !mine
              ? SizedBox(
                  height: 48,
                  width: 48,
                  child: CachedNetworkImageWidget(
                      imageURL: image,
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.black),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          )),
                )
              : SizedBox(
                  height: 48,
                  width: 48,
                  child: CachedNetworkImageWidget(
                      imageURL: image,
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          )),
                ),
          AppGaps.wGap20,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !read && !mine
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                name,
                                style: AppTextStyles.bodyBoldTextStyle,
                              ),
                              AppGaps.wGap10,
                              Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                              )
                            ],
                          ),
                          Text(
                            Helper.getRelativeDateTimeText(datetime),
                            style: AppTextStyles.smallestBoldTextStyle
                                .copyWith(color: AppColors.darkColor),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: AppTextStyles.bodyBoldTextStyle,
                          ),
                          Text(
                            Helper.getRelativeDateTimeText(datetime),
                            style: AppTextStyles.smallestTextStyle
                                .copyWith(color: AppColors.bodyTextColor),
                          )
                        ],
                      ),
                AppGaps.hGap4,
                if (read && mine)
                  Row(
                    children: [
                      Text('You ➤ ${message}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.smallestTextStyle.copyWith(
                            color: AppColors.bodyTextColor,
                          )),
                      AppGaps.wGap5,
                      const SvgPictureAssetWidget(
                        AppAssetImages.doubleTikSVGLogoLine,
                        color: Colors.blue,
                        height: 24,
                        width: 24,
                      )
                    ],
                  ),
                if (!read && mine)
                  Row(
                    children: [
                      Text(
                          '${AppLanguageTranslation.youTransKey.toCurrentLanguage} ➤ ${message}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.smallestTextStyle.copyWith(
                            color: AppColors.bodyTextColor,
                          )),
                      AppGaps.wGap8,
                      const SvgPictureAssetWidget(
                        AppAssetImages.singleTikSVGLogoLine,
                        color: AppColors.bodyTextColor,
                        height: 14,
                        width: 14,
                      )
                    ],
                  ),
                if (!read && !mine)
                  Row(
                    children: [
                      Text(message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.captionMediumTextStyle.copyWith(
                            color: AppColors.darkColor,
                          )),
                    ],
                  ),
                if (read && !mine)
                  Row(
                    children: [
                      Text(message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.smallestTextStyle.copyWith(
                            color: AppColors.bodyTextColor,
                          )),
                    ],
                  ),
                /* !read
                    ? mine
                        ? Row(
                            children: [
                              Text('You ➤ ${message}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.captionMediumTextStyle
                                      .copyWith(
                                    color: AppColors.darkColor,
                                  )),
                            ],
                          )
                        : Row(
                            children: [
                              Text(message,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.captionMediumTextStyle
                                      .copyWith(
                                    color: AppColors.darkColor,
                                  )),
                            ],
                          )
                    : Row(
                        children: [
                          Text(message,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.smallestTextStyle.copyWith(
                                color: AppColors.bodyTextColor,
                              )),
                        ],
                      ) */
              ],
            ),
          )
        ],
      ),
    );
  }
}
