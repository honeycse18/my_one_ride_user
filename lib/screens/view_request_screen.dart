import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/view_requests_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';

class ViewRequestsScreen extends StatelessWidget {
  const ViewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewRequestsScreenController>(
        global: false,
        init: ViewRequestsScreenController(),
        builder: (controller) => WillPopScope(
              onWillPop: () async {
                controller.popScope();
                return await Future.value(true);
              },
              child: Scaffold(
                backgroundColor: AppColors.mainBg,
                appBar: CoreWidgets.appBarWidget(
                    screenContext: context,
                    hasBackButton: true,
                    titleWidget: Text(AppLanguageTranslation
                        .requestsScreenTransKey.toCurrentLanguage)),
                body: RefreshIndicator(
                  onRefresh: () async {
                    controller.getRequestDetails();
                    controller.update();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(24),
                        sliver: SliverList.separated(
                          itemBuilder: (context, index) {
                            PullingOfferDetailsRequest request =
                                controller.requestDetails.pending[index];
                            return Container(
                              height:
                                  controller.requestDetails.type == 'vehicle'
                                      ? 297
                                      : 262,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: CachedNetworkImageWidget(
                                          imageURL: request.user.image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: AppComponents
                                                    .imageBorderRadius,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                      AppGaps.wGap8,
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    request.user.name,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                ),
                                                if (controller
                                                        .requestDetails.type ==
                                                    "vehicle")
                                                  AppGaps.wGap5,
                                                if (request.seats > 1 &&
                                                    controller.requestDetails
                                                            .type ==
                                                        "vehicle")
                                                  const Text(
                                                    '+',
                                                    style: AppTextStyles
                                                        .bodyLargeSemiboldTextStyle,
                                                  ),
                                                if (controller
                                                        .requestDetails.type ==
                                                    "vehicle")
                                                  Expanded(
                                                    child: Row(
                                                      children: List.generate(
                                                          request.seats > 2
                                                              ? 3
                                                              : request.seats -
                                                                  1, (index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      1),
                                                          child: Container(
                                                            width:
                                                                19, // Adjust the size of the dot as needed
                                                            height: 19,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Color(
                                                                  0xFFD9D9D9),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const SingleStarWidget(
                                                    review: 3),
                                                AppGaps.wGap4,
                                                Text(
                                                  '(531 ${controller.requestDetails.type == "vehicle" ? "Trips" : "Rides"})',
                                                  style: AppTextStyles
                                                      .bodySmallTextStyle,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '${Helper.getCurrencyFormattedWithDecimalAmountText(request.rate)} ',
                                                style: AppTextStyles
                                                    .bodySmallSemiboldTextStyle,
                                              ),
                                              Text(
                                                ' / ${AppLanguageTranslation.perSeatTransKey.toCurrentLanguage}',
                                                style: AppTextStyles
                                                    .bodySmallSemiboldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor),
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
                                                ' ${request.seats}  seat${request.seats > 1 ? "s" : ""} ${controller.requestDetails.type == "vehicle" ? AppLanguageTranslation.neededTransKey.toCurrentLanguage : AppLanguageTranslation.avilableTransKey.toCurrentLanguage}',
                                                style: AppTextStyles
                                                    .smallestSemiboldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .bodyTextColor),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  AppGaps.hGap12,
                                  if (controller.requestDetails.type ==
                                      'vehicle')
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLanguageTranslation
                                              .startDateTimeTransKey
                                              .toCurrentLanguage,
                                          style: AppTextStyles
                                              .bodyLargeTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor),
                                        ),
                                        Text(
                                          Helper
                                              .ddMMMyyyyhhmmaFormattedDateTime(
                                                  controller
                                                      .requestDetails.date),
                                          style: AppTextStyles
                                              .bodyLargeMediumTextStyle
                                              .copyWith(
                                                  color: AppColors.darkColor),
                                        )
                                      ],
                                    ),
                                  if (controller.requestDetails.type ==
                                      'vehicle')
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLanguageTranslation
                                                  .pickUpTransKey
                                                  .toCurrentLanguage,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodySmallTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                            AppGaps.hGap4,
                                            Text(
                                              controller
                                                  .requestDetails.from.address,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeMediumTextStyle,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLanguageTranslation
                                                  .dropLocTransKey
                                                  .toCurrentLanguage,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodySmallTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .bodyTextColor),
                                            ),
                                            AppGaps.hGap4,
                                            Text(
                                              controller
                                                  .requestDetails.to.address,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles
                                                  .bodyLargeMediumTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                          child:
                                              CustomStretchedOutlinedButtonWidget(
                                                  onTap: () => controller
                                                      .onRejectButtonTap(
                                                          request.id),
                                                  child: const Text('Reject'))),
                                      AppGaps.wGap50,
                                      Expanded(
                                          child: StretchedTextButtonWidget(
                                              onTap: () =>
                                                  controller.onAcceptButtonTap(
                                                      request.id),
                                              buttonText: AppLanguageTranslation
                                                  .acceptTransKey
                                                  .toCurrentLanguage))
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => AppGaps.hGap16,
                          itemCount: controller.pendingRequests.length,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
