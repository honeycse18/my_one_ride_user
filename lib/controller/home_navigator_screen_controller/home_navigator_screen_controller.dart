import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_ride_user/controller/socket_controller.dart';
import 'package:one_ride_user/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:one_ride_user/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_user/models/api_responses/ride_details_response.dart';
import 'package:one_ride_user/models/api_responses/ride_request_update_socket_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/screens/home_navigator_screen/home_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/message_list_screen.dart';
import 'package:one_ride_user/screens/home_navigator_screen/profile_screen.dart';
import 'package:one_ride_user/screens/home_screen_without_login.dart';
import 'package:one_ride_user/screens/my_trip_screen.dart';
import 'package:one_ride_user/screens/my_wallet_screen.dart';
import 'package:one_ride_user/screens/unknown_screen.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/constants/app_language_translations.dart';
import 'package:one_ride_user/utils/constants/app_page_names.dart';
import 'package:one_ride_user/utils/extensions/string.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';
import 'package:one_ride_user/utils/helpers/api_repo.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:one_ride_user/widgets/core_widgets.dart';
import 'package:one_ride_user/widgets/dialogs.dart';

class HomeNavigatorScreenController extends GetxController {
  String titleText = '';
  PullingNewRequestSocketResponse newRequestOfferId =
      PullingNewRequestSocketResponse();
  PullingRequestStatusSocketResponse requestStatusSocketResponse =
      PullingRequestStatusSocketResponse();
  Widget nestedScreenWidget = const Scaffold();
  int currentPageIndex = 2;
  RideRequestStatus? rideRequestStatus;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideRequestUpdateSocketResponse> rideRequestSocketResponse =
      RideRequestUpdateSocketResponse().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;
  RentStatusSocketResponse rentStatusUpdate = RentStatusSocketResponse.empty();
  // final GlobalKey<ScaffoldState> homeNavigationKey = GlobalKey();
/* 
  IO.Socket socket = IO.io(
      AppConstants.appBaseURL,
      IO.OptionBuilder()
          // .setAuth(Helper.getAuthHeaderMap())
          .setAuth(<String, String>{
        'token': Helper.getUserToken()
      }).setTransports(['websocket']) // for Flutter or Dart VM
          .build());

  dynamic onRideRequestStatus(dynamic data) async {
    log('data socket');
    final RideRequestUpdateSocketResponse mapData =
        RideRequestUpdateSocketResponse.getAPIResponseObjectSafeValue(data);
    rideRequestSocketResponse.value = mapData;
    update();
  }

  dynamic onRideRequestStatusUpdate(dynamic data) async {
    final RideDetailsData mapData =
        RideDetailsData.getAPIResponseObjectSafeValue(data);
    rideDetails.value = mapData;
    update();
    log('Ride is updated!');
  }

  dynamic onNewMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    newMessageData.value = mapData;
    update();
  }

  dynamic onUpdateMessages(dynamic data) {
    log(data.toString());
    final ChatMessageListItem mapData =
        ChatMessageListItem.getAPIResponseObjectSafeValue(data);
    updatedMessageData.value = mapData;
    update();
  }

  void _initSocket() {
    socket.on('ride_request_status', onRideRequestStatus);
    socket.on('ride_update', onRideRequestStatusUpdate);
    socket.on('new_message', onNewMessages);
    socket.on('update_message', onUpdateMessages);
    socket.onConnect((data) {
      log('data');
      // socket.emit('load_message', <String, dynamic>{'user': chatUser.id});
    });
    /* socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err)); */
    socket.onConnectError((data) {
      log('data connect Error'.toString());
    });
    socket.onConnecting((data) {
      log('data Connecting'.toString());
    });
    socket.onConnectTimeout((data) {
      log('data Connect Timeout');
    });
    socket.onReconnectAttempt((data) {
      log('data Reconnect Attempt');
    });
    socket.onReconnect((data) {
      log('data Reconnect');
    });
    socket.onReconnectFailed((data) {
      log('data Reconnect Failed');
    });
    socket.onReconnectError((data) {
      log('data Reconnect Error');
    });
    socket.onError((data) {
      log('data Error');
    });
    socket.onDisconnect((data) {
      log('data Disconnect');
    });
    socket.onPing((data) {
      log('data Ping');
    });
    socket.onPong((data) {
      log('data Pong');
    });
  }
 */
/*   void gotoSignInScreen() async {
    await AppDialogs.showExpireDialog(
      messageText:
          AppLanguageTranslation.sessionExpiredTransKey.toCurrentLanguage,
    );
    Get.offAllNamed(AppPageNames.logInScreen, arguments: true);
  } */
  void gotoSignInScreen() async {
    Get.snackbar(
      'Session Expired',
      AppLanguageTranslation.sessionExpiredTransKey.toCurrentLanguage,
    );
    Get.offAllNamed(AppPageNames.logInScreen, arguments: true);
  }

  Future<void> getLoggedInUserDetails() async {
    UserDetailsResponse? response = await APIRepo.getUserDetails();
    if (response == null) {
      onErrorGetLoggedInUserDetails(response);
      return;
    } else if (response.error) {
      onFailureGetLoggedInUserDetails(response);
      return;
    }
    log((response.toJson().toString()).toString());
    onSuccessGetLoggedInDriverDetails(response);
  }

  void onErrorGetLoggedInUserDetails(UserDetailsResponse? response) {
    gotoSignInScreen();
  }

  void onFailureGetLoggedInUserDetails(UserDetailsResponse response) {
    gotoSignInScreen();
  }

  void onSuccessGetLoggedInDriverDetails(UserDetailsResponse response) async {
    await Helper.setLoggedInUserToLocalStorage(response.data);
    BuildContext? context = Get.context;
    if (context != null) {
      Get.toNamed(AppPageNames.homeNavigatorScreen);
    }
  }

/* <-------- Select current tab screen --------> */
  void setCurrentTab() {
    const int bookingHistoryScreenIndex = 0;
    const int walletScreenIndex = 1;
    const int homeScreenIndex = 2;
    const int messageScreenIndex = 3;
    const int accountScreenIndex = 4;
    switch (currentPageIndex) {
      case bookingHistoryScreenIndex:
        nestedScreenWidget = const MyTripScreen();
        titleText = 'My Trip';
        break;
      case walletScreenIndex:
        nestedScreenWidget = const MyWalletScreen();
        titleText = 'My Wallet';
        break;
      case homeScreenIndex:
        nestedScreenWidget = const HomeScreenWithoutLogin();
        titleText = '';
        break;
      case messageScreenIndex:
        nestedScreenWidget = const MessageListScreen();
        titleText = 'Chat';

        // nestedScreenWidget = const MessageRecipientsScreen();
        // nestedScreenWidget = const ChatRecipientsScreen();
        break;
      case accountScreenIndex:
        nestedScreenWidget = const MyAccountScreen();
        titleText = '';
        update();
        break;
      default:
        // Invalid page index set tab to dashboard screen
        nestedScreenWidget = const HomeScreen();
        titleText = '';
    }
    update();
  }

  Widget bottomMenuButton(String name, String image, int index) {
    return GestureDetector(
      child: Container(
        width: 50,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPictureAssetWidget(
              image,
              color: (currentPageIndex == index)
                  ? AppColors.primaryColor
                  : AppColors.bodyTextColor,
            ),
            AppGaps.hGap4,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: (currentPageIndex == index)
                            ? AppColors.primaryColor
                            : AppColors.bodyTextColor,
                        fontSize: 12,
                        fontWeight: (currentPageIndex == index)
                            ? FontWeight.w500
                            : FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        if (Helper.isUserLoggedIn()) {
          homeNavigatorTabIndex(index);
        } else {
          selectHomeNavigatorTabIndex(index);
        }
      },
    );
  }

  void selectHomeNavigatorTabIndex(int index) {
    if (index == 2) {
      currentPageIndex = index;
    } else {
      // APIHelper.onFailure('Please Login First', '');
      Get.toNamed(AppPageNames.logInScreen);
    }

    setCurrentTab();
  }

  void homeNavigatorTabIndex(int index) {
    currentPageIndex = index;

    setCurrentTab();
  }

  void _getScreenParameter() {
    final argument = Get.arguments;
    if (argument != null) {
      if (argument is int) {
        currentPageIndex = argument;
      }
    }
  }

  dynamic onNewPullingRequest(dynamic data) async {
    if (data is PullingNewRequestSocketResponse) {
      newRequestOfferId = data;
      update();
      if (newRequestOfferId.offer.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: 'You Have a new Request. Please Check it.');
      }
    }
  }

  dynamic onPullingRequestStatusUpdate(dynamic data) async {
    if (data is PullingRequestStatusSocketResponse) {
      requestStatusSocketResponse = data;
      update();
      if (requestStatusSocketResponse.status.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: 'Your Request has an update. Please Check it.');
      }
    }
  }

  dynamic onRentStatusUpdate(dynamic data) {
    if (data is RentStatusSocketResponse) {
      rentStatusUpdate = data;
      update();
      if (rentStatusUpdate.id.isNotEmpty) {
        AppDialogs.showSuccessDialog(
            messageText: 'Your rent has an update. Please check it.');
      }
    }
  }

  StreamSubscription<PullingNewRequestSocketResponse>? listen;
  StreamSubscription<PullingRequestStatusSocketResponse>? listen2;
  StreamSubscription<RentStatusSocketResponse>? listen3;

  @override
  void onInit() {
    _getScreenParameter();
    setCurrentTab();
    if (Helper.isUserLoggedIn()) {
      /* if (!socket.connected) {
      _initSocket();
    } */
      // Helper.checkForUpdate();
      Get.put(SocketController(), permanent: true);
      getLoggedInUserDetails();
      // _getScreenParameter();
      // setCurrentTab();

      SocketController socketController = Get.find<SocketController>();
      if (listen == null) {
        listen = socketController.pullingRequestResponseData.listen((p0) {
          // onNewPullingRequest(p0);
        });
        listen?.onData((data) {
          onNewPullingRequest(data);
        });
      }
      if (listen2 == null) {
        listen2 =
            socketController.pullingRequestStatusResponseData.listen((p0) {});
        listen2?.onData((data) {
          onPullingRequestStatusUpdate(data);
        });
      }
      listen3 = socketController.rentStatusSocketData.listen((p0) {
        onRentStatusUpdate(p0);
      });
    }

    // initSocket();
    super.onInit();
  }

  void popScope() {
    listen?.cancel();
    listen2?.cancel();
    listen3?.cancel();
  }

  @override
  void onClose() {
    // socket.disconnect();
    // socket.close();
    // socket.dispose();
    popScope();
    super.onClose();
  }
}
