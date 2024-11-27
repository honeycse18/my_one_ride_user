import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/message_list_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';

class MessageListScreenController extends GetxController {
  int selectedTabIndex = 0;
  Rx<MessageTypeStatus> messageTypeTab = MessageTypeStatus.driver.obs;
  MessageUserListItem chatUser = MessageUserListItem.empty();

  PagingController<int, MessageUserListItem> chatUserPagingController =
      PagingController(firstPageKey: 1);

  void onTabTap(MessageTypeStatus value) {
    value != MessageTypeStatus.admin
        ? messageTypeTab.value = value
        : Get.toNamed(AppPageNames.adminChatScreen);
    chatUserPagingController.refresh();
    update();
  }

  Future<void> getChatUsersList(int currentPageNumber) async {
    final String key = messageTypeTab.value.stringValue;
    MessageUserListResponse? response =
        await APIRepo.getChatUsersList(currentPageNumber, key);
    if (response == null) {
      APIHelper.onError(response?.msg);
      return;
    } else if (response.error) {
      APIHelper.onFailure(response.msg);
      return;
    }
    log((response.toJson().toString()));
    onSuccessGetChatUsersList(response);
  }

  void onSuccessGetChatUsersList(MessageUserListResponse response) {
    final isLastPage = !response.data.hasNextPage;
    if (isLastPage) {
      chatUserPagingController.appendLastPage(response.data.docs);
      return;
    }
    final nextPageNumber = response.data.page + 1;
    chatUserPagingController.appendPage(response.data.docs, nextPageNumber);
  }

  @override
  void onInit() {
    SocketController homeSocketController = Get.find<SocketController>();

    homeSocketController.newMessageData.listen((p0) {
      chatUserPagingController.refresh();
      update();
    });
    chatUserPagingController.addPageRequestListener((pageKey) {
      getChatUsersList(pageKey);
    });

    super.onInit();
  }
}
