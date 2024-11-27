import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/user_notification_screen_controller.dart';
import 'package:one_ride_user/models/api_responses/notification_list_response.dart';
import 'package:one_ride_user/utils/constants/app_colors.dart';
import 'package:one_ride_user/utils/constants/app_gaps.dart';
import 'package:one_ride_user/utils/constants/app_images.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_text_styles.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/notifications_screen_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserNotificationScreenController>(
        global: false,
        init: UserNotificationScreenController(),
        builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: CoreWidgets.appBarWidget(
                screenContext: context,
                titleWidget: Text(AppLanguageTranslation
                    .notificationsTransKey.toCurrentLanguage),
                actions: [
                  RawButtonWidget(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 24,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Center(
                          child: Text(
                        AppLanguageTranslation
                            .readAllTransKey.toCurrentLanguage,
                        style: AppTextStyles.bodySemiboldTextStyle
                            .copyWith(color: AppColors.primaryColor),
                      )),
                    ),
                    onTap: () {
                      controller.readAllNotification();
                      controller.userNotificationPagingController.refresh();
                    },
                  )
                ]),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () async =>
                      controller.userNotificationPagingController.refresh(),
                  child: PagedListView.separated(
                    pagingController:
                        controller.userNotificationPagingController,
                    builderDelegate: CoreWidgets.pagedChildBuilderDelegate<
                        NotificationListItem>(
                      noItemFoundIndicatorBuilder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EmptyScreenWidget(
                              isSVGImage: true,
                              localImageAssetURL:
                                  AppAssetImages.notificationButtonSVGLogoLine,
                              title: AppLanguageTranslation
                                  .youHaveTransKey.toCurrentLanguage,
                              shortTitle: '',
                            ),
                          ],
                        );
                      },
                      itemBuilder: (context, item, index) {
                        final notification = item;
                        final previousNotification =
                            controller.previousNotification(index, item);
                        final bool isNotificationDateChanges =
                            controller.isNotificationDateChanges(
                                item, previousNotification);
                        return NotificationWidget(
                          action: notification.action,
                          tittle: notification.title,
                          description: notification.message,
                          dateTime: notification.createdAt,
                          isDateChanged: isNotificationDateChanges,
                          notificationType: notification.action,
                          isRead: notification.read,
                          onTap: () {
                            controller.readNotification(notification.id);
                            controller.userNotificationPagingController
                                .refresh();
                          },
                        );
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        AppGaps.hGap24,
                  ),
                ),
              ),
            )));
  }
}
