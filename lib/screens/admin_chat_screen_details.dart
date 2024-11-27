import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/admin_chat_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/chat_screen_widgets.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsetPaddingValue = MediaQuery.of(context).viewInsets.bottom;
    return GetBuilder<AdminChatScreenController>(
        global: false,
        init: AdminChatScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              /* <-------- Appbar --------> */
              appBar: CoreWidgets.appBarWidget(
                automaticallyImplyLeading: false,
                screenContext: context,
                titleWidget: Text(
                  AppLanguageTranslation.adminTransKey.toCurrentLanguage,
                  style: AppTextStyles.bodyLargeMediumTextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                /* actions: [
                  SuperTooltip(
                    backgroundColor: AppColors.primaryColor,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          child: CachedNetworkImageWidget(
                            imageURL: controller.getUser.image,
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: AppComponents.imageBorderRadius,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        AppGaps.hGap10,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.getUser.name,
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                            AppGaps.wGap8,
                            Text(
                              '(${controller.getUser.role})',
                              style: AppTextStyles.bodyTextStyle
                                  .copyWith(color: AppColors.mainTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CachedNetworkImageWidget(
                        imageURL: controller.getUser.image,
                        imageBuilder: (context, imageProvider) => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  AppGaps.wGap15,
                ], */
              ),
              /* <-------- Content --------> */
              body: ScaffoldBodyWidget(
                  child: Column(
                children: [
                  Expanded(
                    child: PagedListView.separated(
                        reverse: true,
                        pagingController:
                            controller.chatMessagePagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<ChatMessageListItem>(
                                noItemsFoundIndicatorBuilder: (context) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 155,
                                width: 155,
                                child: CachedNetworkImageWidget(
                                  imageURL: controller.getUser.image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              ),
                              AppGaps.hGap15,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.getUser.name,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                  ),
                                  AppGaps.wGap5,
                                  Text('(${controller.getUser.role})',
                                      style: AppTextStyles.bodyLargeTextStyle
                                          .copyWith(
                                        color: AppColors.bodyTextColor,
                                      )),
                                ],
                              ),
                              AppGaps.hGap60,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLanguageTranslation.startChattingTransKey
                                        .toCurrentLanguage,
                                    style:
                                        AppTextStyles.bodyLargeMediumTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }, itemBuilder: (context, item, index) {
                          final ChatMessageListItem chatMessage = item;
                          return ChatDeliveryManScreenWidgets
                              .getCustomDeliveryChatWidget(
                                  image: chatMessage.from.image,
                                  name: chatMessage.from.name,
                                  dateTime: chatMessage.createdAt,
                                  message: chatMessage.message,
                                  isMyMessage:
                                      controller.isMyChatMessage(chatMessage));
                        }),
                        separatorBuilder: (context, index) => AppGaps.hGap24),
                  ),
                  AppGaps.hGap10,
                ],
              )),

              /* Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppGaps.screenPaddingValue),
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                    /* <---- Chat background image ----> */
                    ),
                child: SafeArea(
                  bottom: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppGaps.hGap10,
                      /* <---- Chat with deliveryman ----> */
                      Expanded(
                          child: ListView.separated(
                        controller: controller.chatScrollController,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 17, bottom: 30),
                        separatorBuilder: (context, index) => AppGaps.hGap24,
                        itemCount: FakeData.chatMessages.length,
                        itemBuilder: (context, index) {
                          /// Per chat message data
                          final chatMessage = FakeData.chatMessages[index];
                          /* final chatMessage = controller.chatMessages[index]; */
                          return ChatDeliveryManScreenWidgets
                              .getCustomDeliveryChatWidget(
                                  firstName: 'Admin',
                                  lastName: 'B',
                                  dateTime: DateTime.now(),
                                  message: chatMessage.message,
                                  isMyMessage: false);
                        },
                      )),
                    ],
                  ),
                ),
              ), */
              /* <-------- Bottom bar of chat text field --------> */
              bottomNavigationBar: Padding(
                padding: AppGaps.bottomNavBarPadding
                    .copyWith(bottom: 15 + bottomInsetPaddingValue),
                /* <---- Chat message text field ----> */
                child: CustomTextFormField(
                  controller: controller.messageController,
                  hintText: AppLanguageTranslation
                      .enterYourTextTransKey.toCurrentLanguage,
                  prefixIcon: const SizedBox.shrink(),
                  suffixIconConstraints: const BoxConstraints(maxHeight: 48),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Attachment icon button ----> */
                      /* CustomIconButtonWidget(
                        child: SvgPicture.asset(
                          AppAssetImages.attachmentSVGLogoSolid,
                          height: 24,
                          width: 24,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ), */
                      /* AppGaps.wGap8,

                      /* <---- Camera icon button ----> */
                      CustomIconButtonWidget(
                        child: SvgPicture.asset(
                          AppAssetImages.cameraButtonSVGLogoLine,
                          height: 24,
                          width: 24,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ), */
                      AppGaps.wGap8,
                      /* <---- Send icon button ----> */
                      CustomIconButtonWidget(
                        border: Border.all(color: AppColors.primaryColor),
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.7),
                        hasShadow: true,
                        onTap: () {
                          controller.sendAdminMessage();
                        },
                        child: Transform.scale(
                          scaleX: -1,
                          child: const SvgPictureAssetWidget(
                            AppAssetImages.arrowLeftSVGLogoLine,
                            height: 16,
                            width: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
