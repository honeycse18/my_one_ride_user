import 'package:one_ride_user/utils/helpers/api_helper.dart';

class PullingRequestStatusSocketResponse {
  String request;
  String offer;
  String status;

  PullingRequestStatusSocketResponse({
    this.request = '',
    this.offer = '',
    this.status = '',
  });

  factory PullingRequestStatusSocketResponse.fromJson(
      Map<String, dynamic> json) {
    return PullingRequestStatusSocketResponse(
      request: APIHelper.getSafeStringValue(json['request']),
      offer: APIHelper.getSafeStringValue(json['offer']),
      status: APIHelper.getSafeStringValue(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'request': request,
        'offer': offer,
        'status': status,
      };

  static PullingRequestStatusSocketResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingRequestStatusSocketResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingRequestStatusSocketResponse();
}
