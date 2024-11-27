import 'dart:convert';

import 'package:get/get.dart';
import 'package:one_ride_user/models/api_responses/about_us_response.dart';
import 'package:one_ride_user/models/api_responses/all_categories_response.dart';
import 'package:one_ride_user/models/api_responses/car_rent_details_response.dart';
import 'package:one_ride_user/models/api_responses/car_rent_response.dart';
import 'package:one_ride_user/models/api_responses/chat_message_list_response.dart';
import 'package:one_ride_user/models/api_responses/chat_message_list_sender_response.dart';
import 'package:one_ride_user/models/api_responses/contact_us_response.dart';
import 'package:one_ride_user/models/api_responses/core_api_responses/raw_api_response.dart';
import 'package:one_ride_user/models/api_responses/country_list_response.dart';
import 'package:one_ride_user/models/api_responses/driver_details_response.dart';
import 'package:one_ride_user/models/api_responses/find_account_response.dart';
import 'package:one_ride_user/models/api_responses/get_user_data_response.dart';
import 'package:one_ride_user/models/api_responses/get_wallet_details_response.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:one_ride_user/models/api_responses/get_withdraw_saved_methods_details.dart';
import 'package:one_ride_user/models/api_responses/google_map_poly_lines_response.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_details_response.dart';
import 'package:one_ride_user/models/api_responses/hire_driver_list_response.dart';
import 'package:one_ride_user/models/api_responses/language_translations_response.dart';
import 'package:one_ride_user/models/api_responses/languages_response.dart';
import 'package:one_ride_user/models/api_responses/login_response.dart';
import 'package:one_ride_user/models/api_responses/message_list_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_cars_list_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_driver_response.dart';
import 'package:one_ride_user/models/api_responses/nearest_pulling_requests_response.dart';
import 'package:one_ride_user/models/api_responses/notification_list_response.dart';
import 'package:one_ride_user/models/api_responses/otp_request_response.dart';
import 'package:one_ride_user/models/api_responses/otp_verification_response.dart';
import 'package:one_ride_user/models/api_responses/post_pulling_request_response.dart';
import 'package:one_ride_user/models/api_responses/post_rent_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_offer_details_response.dart';
import 'package:one_ride_user/models/api_responses/pulling_request_details_response.dart';
import 'package:one_ride_user/models/api_responses/recent_location_response.dart';
import 'package:one_ride_user/models/api_responses/registration_response.dart';
import 'package:one_ride_user/models/api_responses/rent_details_response.dart';
import 'package:one_ride_user/models/api_responses/rent_vehicle_list_response.dart';
import 'package:one_ride_user/models/api_responses/ride_details_response.dart';
import 'package:one_ride_user/models/api_responses/ride_history_response.dart';
import 'package:one_ride_user/models/api_responses/saved_location_list_response.dart';
import 'package:one_ride_user/models/api_responses/schedule_ride_post_response.dart';
import 'package:one_ride_user/models/api_responses/share_ride_history_response.dart';
import 'package:one_ride_user/models/api_responses/support_text_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/models/api_responses/wallet_history_response.dart';
import 'package:one_ride_user/models/api_responses/withdraw_history_response.dart';
import 'package:one_ride_user/utils/api_client.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class APIRepo {
  static Future<GoogleMapPolyLinesResponse?> getRoutesPolyLines(
      double originLatitude,
      double originLongitude,
      double targetLatitude,
      double targetLongitude) async {
    try {
      await APIHelper.preAPICallCheck();
      // final GetHttpClient apiHttpClient = APIClient.instance.googleMapsAPIClient();
      final Map<String, dynamic> queries = {
        'origin': '$originLatitude,$originLongitude',
        'destination': '$targetLatitude,$targetLongitude',
        'sensor': 'false',
        'key': AppConstants.googleAPIKey,
      };
      final Response response =
          // await apiHttpClient.get('/maps/api/directions/json', query: queries);
          await APIClient.instance.requestGetMapMethod(
              url: '/maps/api/directions/json', queries: queries);
      APIHelper.postAPICallCheck(response);
      final GoogleMapPolyLinesResponse responseModel =
          GoogleMapPolyLinesResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListResponse?> getChatMessageList(
      int currentPageNumber, String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'with': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NotificationListResponse?> getNotificationList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/notification/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NotificationListResponse responseModel =
          NotificationListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetWalletDetailsResponse?> getWalletDetails() async {
    try {
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetWalletDetailsResponse responseModel =
          GetWalletDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetUserDataResponse?> getIdUserDetails(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/user/details',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final GetUserDataResponse responseModel =
          GetUserDataResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListResponse?> getAdminChatMessageList(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/admin',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ChatMessageListResponse responseModel =
          ChatMessageListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<FindAccountResponse?> findAccount(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/find', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
        url: '/api/user/find',
        requestBody: requestBody,
      );
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final FindAccountResponse responseModel =
          FindAccountResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> acceptRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListSendResponse?> sendAdminMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message/admin',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  //-----------------------------------
  static Future<RawAPIResponse?> hireDriver(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/driver/hire',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  //-----------------------------------
  static Future<RawAPIResponse?> deleteUserAccount() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response =
          await APIClient.instance.requestDeleteMethodAsURLEncoded(
        url: '/api/user',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  //-----------------------------------
  static Future<RawAPIResponse?> requestRide(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      String requestBodyJson = jsonEncode(requestBody);
      final Response response =
          await APIClient.instance.requestPostMethodAsJSONEncoded(
        url: '/api/pulling/request',
        requestBody: requestBodyJson,
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> topUpWallet(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/wallet/add',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> onPaymentTap(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/ride/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HireDriverListResponse?> getHireDriverList(
      {required int page, required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/hire/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HireDriverListResponse responseModel =
          HireDriverListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PostRentResponse?> getPendingRentDetails(
      {required String id}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final PostRentResponse responseModel =
          PostRentResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<AboutUsResponse?> getAboutUsText() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': 'about_us'};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final AboutUsResponse responseModel =
          AboutUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SupportTextResponse?> getSupportText(
      {required String slug}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'slug': slug};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final SupportTextResponse responseModel =
          SupportTextResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ContactUsResponse?> getContactUsDetails() async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'slug': 'contact_us',
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/page',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ContactUsResponse responseModel =
          ContactUsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentDetailsResponse?> getRentDetails(
      {required String id}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': id};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RentDetailsResponse responseModel =
          RentDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarRentListResponse?> getRentCarList(
      {required int page, required String key}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'page': '$page', 'status': key};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CarRentListResponse responseModel =
          CarRentListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpRequestResponse?> requestOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/send-otp', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/send-otp', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpRequestResponse responseModel =
          OtpRequestResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NearestDriverResponse?> getNearestDriverList(
      {required int page, required double lat, required double lng}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'lat': '$lat',
        'lng': '$lng'
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/nearest',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final NearestDriverResponse responseModel =
          NearestDriverResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<MessageUserListResponse?> getChatUsersList(
      int currentPageNumber, String key) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        'page': '$currentPageNumber',
        'type': key
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/message/users',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final MessageUserListResponse responseModel =
          MessageUserListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WalletTransactionHistoryResponse?> getTransactionHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/wallet/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WalletTransactionHistoryResponse responseModel =
          WalletTransactionHistoryResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<WithdrawHistoryResponse?> getWithdrawRequestHistory(
      int currentPageNumber) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {'page': '$currentPageNumber'};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/withdraw/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final WithdrawHistoryResponse responseModel =
          WithdrawHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ChatMessageListSendResponse?> sendMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final ChatMessageListSendResponse responseModel =
          ChatMessageListSendResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> submitReviews(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/review',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readAllNotification(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/notification/read/all',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<HireDriverDetailsResponse?> getHiredDriverDetails(
      {required String hireDriverId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': hireDriverId};

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver/hire',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final HireDriverDetailsResponse responseModel =
          HireDriverDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> rejectRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<DriverDetailsResponse?> getDriverDetails(
      {required String driverId}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {'_id': driverId};

      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/driver',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final DriverDetailsResponse responseModel =
          DriverDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> readMessage(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/message',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> postContactUsMessage(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/contact',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RentVehicleListResponse?> getNearestCarList(
      {required int page, required double lat, required double lng}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        'page': '$page',
        'lat': '$lat',
        'lng': '$lng'
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent/vehicles',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RentVehicleListResponse responseModel =
          RentVehicleListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguageTranslationsResponse?>
      fetchLanguageTranslations() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/language/translations',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguageTranslationsResponse responseModel =
          LanguageTranslationsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateRequest(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/driver/hire',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CarRentDetailsResponse?> getVehicleDetails(
      {required String id}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, String> queries = {
        '_id': id,
      };

      // final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/rent/vehicle',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final CarRentDetailsResponse responseModel =
          CarRentDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LoginResponse?> login(Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/login', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/login', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LoginResponse responseModel =
          LoginResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RegistrationResponse?> registration(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post( '/api/user/registration', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/registration', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RegistrationResponse responseModel =
          RegistrationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<LanguagesResponse?> fetchLanguages() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get(
        '/api/languages',
        headers: APIHelper.getAuthHeaderMap(),
      );

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final LanguagesResponse responseModel =
          LanguagesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<CountryListResponse?> getCountryList() async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsURLEncoded(
              url: '/api/countries', headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final CountryListResponse responseModel =
          CountryListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<OtpVerificationResponse?> verifyOTP(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post('/api/user/verify-otp', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/verify-otp', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final OtpVerificationResponse responseModel =
          OtpVerificationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> createNewPassword(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      // final Map<String, String> queries = {'page': '$pageNumber'};
      // final data = FormData(requestBody);
      final Response response =
          // await apiHttpClient.post( '/api/user/reset-password', body: requestBody, contentType: AppConstants.apiContentTypeFormURLEncoded);
          await APIClient.instance.requestPostMethodAsURLEncoded(
              url: '/api/user/reset-password', requestBody: requestBody);
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<ScheduleRideResponse?> requestForRide(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/request',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ScheduleRideResponse responseModel =
          ScheduleRideResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<RawAPIResponse?> updatePassword(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/user/password',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  /* static Future<ScheduleRideResponse?> scheduleRidePost(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ScheduleRideResponse responseModel =
          ScheduleRideResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  } */

  static Future<RawAPIResponse?> deleteSavedLocation({String? id}) async {
    try {
      await APIHelper.preAPICallCheck();

      final Map<String, dynamic> queries = {'_id': id};
      final Response response = await APIClient.instance
          .requestDeleteMethodAsJSONEncoded(
              url: '/api/location',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  /* static Future<UserSignUpResponse?> signUp(String requestJsonString) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient
          .post('api/user/delivery/signup', body: requestJsonString);

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserSignUpResponse responseModel =
          UserSignUpResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
*/
  static Future<RawAPIResponse?> updateUserProfile(dynamic requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      String contentType = 'multipart/form-data';
      if (requestBody is String) {
        contentType = 'application/json';
      }
      final Response
          response = /* await APIClient.instance.requestPostMethod(
          url: '/api/vehicle',
          requestBody: requestBody,
          headers: APIHelper.getAuthHeaderMap()); */
          await APIClient.instance.apiClient.patch('/api/user/',
              body: requestBody,
              contentType: contentType,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<UserDetailsResponse?> getUserDetails({String? token}) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      // final GetHttpClient apiHttpClient = APIClient.instance.apiClient();
      final Response response =
          // await apiHttpClient.get('/api/user/', headers: token != null ? {'Authorization': 'Bearer $token'} : APIHelper.getAuthHeaderMap());
          await APIClient.instance.requestGetMethodAsJSONEncoded(
              url: '/api/user/',
              headers: token != null
                  ? {'Authorization': 'Bearer $token'}
                  : APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final UserDetailsResponse responseModel =
          UserDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NearestCarsListResponse?> getNearestCarsList(
      {double lat = 0,
      double lng = 0,
      double destLat = 0,
      double destLng = 0,
      String? categoryId,
      int? limit}) async {
    try {
      final Map<String, dynamic> queries = {
        "lat": lat.toString(),
        "lng": lng.toString(),
        "destination": '$destLat,$destLng'
      };
      if (categoryId != null) {
        queries["category"] = categoryId;
      }
      if (limit != null) {
        queries['limit'] = limit.toString();
      }
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/nearest',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestCarsListResponse responseModel =
          NearestCarsListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NearestCarsListResponse?> getNearestCarsListWithOutLogin(
      {double lat = 0, double lng = 0, int? limit}) async {
    try {
      final Map<String, dynamic> queries = {
        'lat': lat.toString(),
        'lng': lng.toString(),
      };

      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/nearest-mobile',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestCarsListResponse responseModel =
          NearestCarsListResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addFavoriteLocation(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/location',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateSavedLocation(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPatchMethodAsJSONEncoded(
              url: '/api/location',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<SavedLocationListResponse?> getSavedLocationList(
      {String? search}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {};
      if (search != null && search.isNotEmpty) {
        queries['search'] = search;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/location/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final SavedLocationListResponse responseModel =
          SavedLocationListResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RecentLocationResponse?> getRecentLocationList(
      {String? search}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {};
      if (search != null && search.isNotEmpty) {
        queries['search'] = search;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/location/recent',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RecentLocationResponse responseModel =
          RecentLocationResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RideDetailsResponse?> getRideDetails(String rideId) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': rideId,
      };
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideDetailsResponse responseModel =
          RideDetailsResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetWithdrawSavedMethodsResponse?> getWithdrawMethod() async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response =
          await apiHttpClient.get('/api/withdraw-method/list',
              // query: queries,
              headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final GetWithdrawSavedMethodsResponse responseModel =
          GetWithdrawSavedMethodsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<GetWithdrawSavedMethodsDetailsResponse?>
      getWithdrawMethodDetails(String id) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };

      final GetHttpClient apiHttpClient = APIClient.instance.getAPIClient();
      final Response response = await apiHttpClient.get('/api/withdraw-method',
          query: queries, headers: APIHelper.getAuthHeaderMap());

      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final GetWithdrawSavedMethodsDetailsResponse responseModel =
          GetWithdrawSavedMethodsDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateRideStatus(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/ride',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> cancelPendingRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/ride/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> withdrawRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/withdraw',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateInfo(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPatchMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> addMethodInfo(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> deleteCard(String id) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> queries = {
        '_id': id,
      };
      final Response response = await APIClient.instance
          .requestDeleteMethodAsJSONEncoded(
              url: '/api/withdraw-method',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> paymentAcceptCarRentRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> paymentAcceptHireDriverRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/driver/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> paymentCarRentRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/rent/payment',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<PostRentResponse?> postRentRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/rent',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PostRentResponse responseModel =
          PostRentResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<NearestPullingRequestsResponse?> getNearestRequests(
      Map<String, String> params, int page) async {
    try {
      await APIHelper.preAPICallCheck();
      if (page > 0) {
        params['page'] = '$page';
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/nearest',
              queries: params,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final NearestPullingRequestsResponse responseModel =
          NearestPullingRequestsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<AllCategoriesResponse?> getAllCategories() async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'limit': '100'};
      final Response response =
          await APIClient.instance.requestGetMethodAsJSONEncoded(
        url: '/api/category/list',
        queries: queries,
      );
      APIHelper.postAPICallCheck(response);
      final AllCategoriesResponse responseModel =
          AllCategoriesResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<PullingOfferDetailsResponse?> getPullingOfferDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PullingOfferDetailsResponse responseModel =
          PullingOfferDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<PullingRequestDetailsResponse?> getPullingRequestDetails(
      String requestId) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'_id': requestId};
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/request',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PullingRequestDetailsResponse responseModel =
          PullingRequestDetailsResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<RideHistoryResponse?> getRideHistory(
      {int page = 1, String filter = ''}) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'page': '$page'};
      if (filter.isNotEmpty) {
        queries['status'] = filter;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/ride/list',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RideHistoryResponse responseModel =
          RideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<ShareRideHistoryResponse?> getShareRideHistory(
      {int page = 1, String filter = '', String action = ''}) async {
    try {
      await APIHelper.preAPICallCheck();
      Map<String, String> queries = {'page': '$page'};
      if (filter.isNotEmpty) {
        queries['status'] = filter;
      }
      if (action.isNotEmpty) {
        queries['action'] = action;
      }
      final Response response = await APIClient.instance
          .requestGetMethodAsJSONEncoded(
              url: '/api/pulling/history',
              queries: queries,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final ShareRideHistoryResponse responseModel =
          ShareRideHistoryResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<PostPullingRequestResponse?> createNewRequest(
      Map<String, dynamic> requestBody) async {
    try {
      await APIHelper.preAPICallCheck();
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final PostPullingRequestResponse responseModel =
          PostPullingRequestResponse.getAPIResponseObjectSafeValue(
              response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<RawAPIResponse?> updateShareRideRequest(
      {required String requestId,
      String action = 'accepted',
      String? reason}) async {
    try {
      await APIHelper.preAPICallCheck();
      final Map<String, String> requestBody = {
        '_id': requestId,
        'status': action
      };
      if (reason != null && reason.isNotEmpty) {
        requestBody['cancel_reason'] = reason;
      }
      final Response response = await APIClient.instance
          .requestPostMethodAsJSONEncoded(
              url: '/api/pulling/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (e) {
      APIHelper.handleExceptions(e);
      return null;
    }
  }

  static Future<RawAPIResponse?> startRideWithSubmitOtp(
      Map<String, dynamic> requestBody) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();

      final Response response = await APIClient.instance
          .requestPostMethodAsURLEncoded(
              url: '/api/pulling/request/status',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }

  static Future<RawAPIResponse?> completeRide(String rideId) async {
    try {
      // Before calling API method, checks for any issues, errors and throw if
      // found
      await APIHelper.preAPICallCheck();
      final Map<String, dynamic> requestBody = {
        '_id': rideId,
        'status': 'completed'
      };
      final Response response = await APIClient.instance
          .requestPatchMethodAsURLEncoded(
              url: '/api/pulling/offer',
              requestBody: requestBody,
              headers: APIHelper.getAuthHeaderMap());
      // After post API call checking, any issues, errors found throw exception
      APIHelper.postAPICallCheck(response);
      final RawAPIResponse responseModel =
          RawAPIResponse.getAPIResponseObjectSafeValue(response.body);
      if (APIHelper.isResponseStatusCodeIn400(response.statusCode)) {
        responseModel.error = true;
      }
      return responseModel;
    } catch (exception) {
      APIHelper.handleExceptions(exception);
      return null;
    }
  }
}
