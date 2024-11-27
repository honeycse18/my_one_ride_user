import 'dart:developer';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_user/models/api_responses/new_hire_socket_response.dart';
import 'package:one_ride_user/models/api_responses/new_rent_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_new_request_socket_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_status_socket_response.dart';
import 'package:one_ride_user/models/api_responses/rent_status_socket_response.dart';
import 'package:one_ride_user/models/api_responses/ride_details_response.dart';
import 'package:one_ride_user/models/api_responses/ride_request_update_socket_response.dart';
import 'package:one_ride_user/models/enums.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/helpers/helpers.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  RideRequestStatus? rideRequestStatus;
  Rx<ChatMessageListItem> newMessageData = ChatMessageListItem.empty().obs;
  Rx<ChatMessageListItem> updatedMessageData = ChatMessageListItem.empty().obs;
  Rx<RideRequestUpdateSocketResponse> rideRequestSocketResponse =
      RideRequestUpdateSocketResponse().obs;
  Rx<RideDetailsData> rideDetails = RideDetailsData.empty().obs;
  Rx<NewRentSocketResponse> newRentSocketData =
      NewRentSocketResponse.empty().obs;
  Rx<RentStatusSocketResponse> rentStatusSocketData =
      RentStatusSocketResponse.empty().obs;
  final Rx<PullingNewRequestSocketResponse> pullingRequestResponseData =
      PullingNewRequestSocketResponse().obs;
  Rx<PullingRequestStatusSocketResponse> pullingRequestStatusResponseData =
      PullingRequestStatusSocketResponse().obs;
  Rx<HireSocketResponse> hireDetails = HireSocketResponse.empty().obs;
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

  dynamic onNewPullingRequest(dynamic data) {
    log(data.toString());
    final PullingNewRequestSocketResponse mapData =
        PullingNewRequestSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestResponseData.value = mapData;
    update();
  }

  dynamic onPullingRequestStatusUpdate(dynamic data) {
    log(data.toString());
    final PullingRequestStatusSocketResponse mapData =
        PullingRequestStatusSocketResponse.getAPIResponseObjectSafeValue(data);
    pullingRequestStatusResponseData.value = mapData;
    update();
  }

  dynamic onNewRent(dynamic data) {
    log(data.toString());
    final NewRentSocketResponse mapData =
        NewRentSocketResponse.getAPIResponseObjectSafeValue(data);
    newRentSocketData.value = mapData;
    update();
  }

  dynamic onRentStatusUpdate(dynamic data) {
    log(data.toString());
    final RentStatusSocketResponse mapData =
        RentStatusSocketResponse.getAPIResponseObjectSafeValue(data);
    rentStatusSocketData.value = mapData;
    update;
  }

  dynamic onHireUpdate(dynamic data) {
    log(data.toString());
    hireDetails.value = HireSocketResponse.getAPIResponseObjectSafeValue(data);
    update();
  }

  void _initSocket() {
    socket.on('ride_request_status', onRideRequestStatus);
    socket.on('ride_update', onRideRequestStatusUpdate);
    socket.on('new_message', onNewMessages);
    socket.on('update_message', onUpdateMessages);
    socket.on('new_admin_message', onNewMessages);
    socket.on('update_admin_message', onUpdateMessages);
    socket.on('pulling_request', onNewPullingRequest);
    socket.on('pulling_request_status', onPullingRequestStatusUpdate);
    socket.on('new_rent', onNewRent);
    socket.on('rent_status', onRentStatusUpdate);
    socket.on('hire_update', onHireUpdate);
    socket.onConnect((data) {
      log('Socket Connect');
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

  @override
  void onInit() {
    if (!socket.connected) {
      _initSocket();
    }
    super.onInit();
  }

  @override
  void onClose() {
    _onClose();
    super.onClose();
  }

  void _onClose() {
    socket.disconnect();
    socket.dispose();
  }
}
