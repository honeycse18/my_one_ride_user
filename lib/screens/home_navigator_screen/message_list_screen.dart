import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/home_navigator_screen_controller/message_list_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/message_list_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/screen_widget/Tab_list_screen_widget.dart';
import 'package:one_ride_user/widgets/screen_widget/chat_list_widget.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageListScreenController>(
        global: false,
        init: MessageListScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainBg,
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: ScaffoldBodyWidget(
                    child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.chatUserPagingController.refresh(),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: AppGaps.hGap10),
                      SliverToBoxAdapter(
                        child: SizedBox(
                            height: 50,
                            child: Obx(() => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .user.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.user,
                                        onTap: () {
                                          controller
                                              .onTabTap(MessageTypeStatus.user);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .driver.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.driver,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.driver);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .owner.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.owner,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.owner);
                                        },
                                      ),
                                      AppGaps.wGap10,
                                      TabStatusWidget(
                                        text: MessageTypeStatus
                                            .admin.stringValueForView,
                                        isSelected:
                                            controller.messageTypeTab.value ==
                                                MessageTypeStatus.admin,
                                        onTap: () {
                                          controller.onTabTap(
                                              MessageTypeStatus.admin);
                                        },
                                      ),
                                    ],
                                  ),
                                ))),
                      ),
                      const SliverToBoxAdapter(child: AppGaps.hGap10),
                      Obx(() {
                        switch (controller.messageTypeTab.value) {
                          case MessageTypeStatus.user:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case MessageTypeStatus.driver:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );

                          case MessageTypeStatus.owner:
                            return PagedSliverList.separated(
                              pagingController:
                                  controller.chatUserPagingController,
                              builderDelegate: PagedChildBuilderDelegate<
                                      MessageUserListItem>(
                                  noItemsFoundIndicatorBuilder: (context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    EmptyScreenWidget(
                                        //-----------------------
                                        localImageAssetURL:
                                            AppAssetImages.confirmIconImage,
                                        title: AppLanguageTranslation
                                            .noChatHistoryTransKey
                                            .toCurrentLanguage,
                                        shortTitle: AppLanguageTranslation
                                            .noMessageTransKey
                                            .toCurrentLanguage)
                                  ],
                                );
                              }, itemBuilder: (context, item, index) {
                                final MessageUserListItem chatUsers = item;
                                return ChatListWidget(
                                  mine: chatUsers.mine,
                                  read: chatUsers.read,
                                  onTap: () async {
                                    await Get.toNamed(AppPageNames.chatScreen,
                                        arguments: chatUsers.id);
                                    controller.chatUserPagingController
                                        .refresh();
                                  },
                                  datetime: chatUsers.createdAt,
                                  image: chatUsers.user.image,
                                  message: chatUsers.message,
                                  name: chatUsers.user.name,
                                );
                              }),
                              separatorBuilder: (context, index) =>
                                  AppGaps.hGap16,
                            );
                          case MessageTypeStatus.admin:
                            return const SliverToBoxAdapter(
                              child: Text(''),
                            );
                        }
                      })
                    ],
                  ),
                )),
              ),
            ));
  }
}
