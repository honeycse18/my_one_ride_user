import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/notification_list_response.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class UserNotificationScreenController extends GetxController {
  final PagingController<int, NotificationListItem>
      userNotificationPagingController = PagingController(firstPageKey: 1);
  RxBool hasBackButton = false.obs;
  NotificationListItem? previousNotification(
      int currentIndex, NotificationListItem notification) {
    log(currentIndex.toString());
    final previousIndex = currentIndex - 1;
    if (previousIndex == -1) {
      return null;
    }
    NotificationListItem? previousNotification =
        userNotificationPagingController.value.itemList?[previousIndex];
    return previousNotification;
    // return notification.previousNotification;
  }

  bool isNotificationDateChanges(NotificationListItem notification,
      NotificationListItem? previousNotification) {
    if (previousNotification == null) {
      return true;
    }
    final notificationDate = DateTime(notification.createdAt.year,
        notification.createdAt.month, notification.createdAt.day);
    final previousNotificationDate = DateTime(
        previousNotification.createdAt.year,
        previousNotification.createdAt.month,
        previousNotification.createdAt.day);
    Duration dateDifference =
        notificationDate.difference(previousNotificationDate);
    return (dateDifference.inDays >= 1 || (dateDifference.inDays <= -1));
  }

  Future<void> getNotifications(int currentPageNumber) async {
    NotificationListResponse? response =
        await APIRepo.getNotificationList(currentPageNumber);
    if (response == null) {
      APIHelper.onError(
          AppLanguageTranslation.noNotificationFoundTransKey.toCurrentLanguage);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    // log(response.toJson().toString());
    onSuccessRetrievingResponse(response);
  }

  onSuccessRetrievingResponse(NotificationListResponse response) {
    final isLastPage = !response.data.hasNextPage;

    if (isLastPage) {
      userNotificationPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    userNotificationPagingController.appendPage(
        response.data.docs, nextPageNumber);
  }

  //------------post method---------------
  Future<void> readNotification(String id) async {
    Map<String, dynamic> requestBody = {
      '_id': id,
    };
    RawAPIResponse? response = await APIRepo.readNotification(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessSendMessage(response);
  }

  _onSuccessSendMessage(RawAPIResponse response) {
    update();
  }

  //------------post method---------------
  Future<void> readAllNotification() async {
    Map<String, dynamic> requestBody = {};
    RawAPIResponse? response = await APIRepo.readAllNotification(requestBody);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log(response.toJson().toString());
    _onSuccessReadAllNotifications(response);
  }

  _onSuccessReadAllNotifications(RawAPIResponse response) {
    update();
  }

  void _getScreenParameters() {
    final argument = Get.arguments;
    if (argument is bool) {
      hasBackButton.value = true;
    }
  }

  @override
  void onInit() {
    _getScreenParameters();
    userNotificationPagingController.addPageRequestListener((pageKey) {
      getNotifications(pageKey);
    });

    super.onInit();
  }
}
