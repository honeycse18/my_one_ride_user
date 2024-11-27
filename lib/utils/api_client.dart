import 'package:get/get.dart';
import 'package:one_ride_user/utils/constants/app_constants.dart';

// class APIClient extends GetConnect {
class APIClient {
  static APIClient? _instance;
  GetHttpClient _appAPIClient = GetHttpClient();
  GetHttpClient _appGoogleMapAPIClient = GetHttpClient();

  APIClient._() {
    _appAPIClient = GetHttpClient(
      timeout: const Duration(minutes: 1),
      baseUrl: AppConstants.appBaseURL,
    );
    _appGoogleMapAPIClient = GetHttpClient(
      timeout: const Duration(seconds: 40),
      baseUrl: AppConstants.googleMapBaseURL,
    );
  }

  static APIClient get instance => _instance ??= APIClient._();

  GetHttpClient get apiClient => _appAPIClient;
  GetHttpClient get googleMapsAPIClient => _appGoogleMapAPIClient;

  Future<Response<dynamic>> requestGetMapMethod({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await googleMapsAPIClient.get(url,
          query: queries,
          contentType: AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);

  Future<Response<dynamic>> requestGetMethodAsURLEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await apiClient.get(url,
          query: queries,
          contentType: AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);

  Future<Response<dynamic>> requestPostMethodAsURLEncoded(
          {required String url,
          required dynamic requestBody,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.post(url,
          body: requestBody,
          contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);

  Future<Response<dynamic>> requestPatchMethodAsURLEncoded(
          {required String url,
          required dynamic requestBody,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.patch(url,
          body: requestBody,
          contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);
  Future<Response<dynamic>> requestDeleteMethodAsURLEncoded(
          {required String url,
          Map<String, dynamic>? queries,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.delete(url,
          query: queries,
          contentType: contentType ?? AppConstants.apiContentTypeFormURLEncoded,
          headers: headers);

  Future<Response<dynamic>> requestGetMethodAsJSONEncoded({
    required String url,
    Map<String, dynamic>? queries,
    Map<String, String>? headers,
  }) async =>
      await apiClient.get(url,
          query: queries,
          contentType: AppConstants.apiContentTypeJSON,
          headers: headers);

  Future<Response<dynamic>> requestPostMethodAsJSONEncoded(
          {required String url,
          required dynamic requestBody,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.post(url,
          body: requestBody,
          contentType: contentType ?? AppConstants.apiContentTypeJSON,
          headers: headers);
  Future<Response<dynamic>> requestPatchMethodAsJSONEncoded(
          {required String url,
          required dynamic requestBody,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.patch(url,
          body: requestBody,
          contentType: contentType ?? AppConstants.apiContentTypeJSON,
          headers: headers);
  Future<Response<dynamic>> requestDeleteMethodAsJSONEncoded(
          {required String url,
          Map<String, dynamic>? queries,
          Map<String, String>? headers,
          String? contentType}) async =>
      await apiClient.delete(url,
          query: queries,
          contentType: contentType ?? AppConstants.apiContentTypeJSON,
          headers: headers);

  GetHttpClient getAPIClient() => _appAPIClient;
}
