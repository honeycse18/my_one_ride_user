import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class NearestPullingRequestsResponse {
  bool error;
  String msg;
  PaginatedDataResponse<NearestRequestsDoc> data;

  NearestPullingRequestsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory NearestPullingRequestsResponse.fromJson(Map<String, dynamic> json) {
    return NearestPullingRequestsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(json['data'],
          docFromJson: (data) =>
              NearestRequestsDoc.getAPIResponseObjectSafeValue(data)),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory NearestPullingRequestsResponse.empty() =>
      NearestPullingRequestsResponse(
        data: PaginatedDataResponse.empty(),
      );
  static NearestPullingRequestsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestPullingRequestsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestPullingRequestsResponse.empty();
}

class NearestRequestsDoc {
  NearestRequestsFrom from;
  NearestRequestsTo to;
  String id;
  String type;
  NearestRequestUser user;
  DateTime date;
  int seats;
  int available;
  int rate;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  NearestRequestsDoc({
    required this.from,
    required this.to,
    this.id = '',
    this.type = '',
    required this.user,
    required this.date,
    this.seats = 0,
    this.available = 0,
    this.rate = 0,
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory NearestRequestsDoc.fromJson(Map<String, dynamic> json) =>
      NearestRequestsDoc(
        from: NearestRequestsFrom.getAPIResponseObjectSafeValue(json['from']),
        to: NearestRequestsTo.getAPIResponseObjectSafeValue(json['to']),
        id: APIHelper.getSafeStringValue(json['_id']),
        type: APIHelper.getSafeStringValue(json['type']),
        user: NearestRequestUser.getAPIResponseObjectSafeValue(json['user']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        seats: APIHelper.getSafeIntValue(json['seats']),
        available: APIHelper.getSafeIntValue(json['available']),
        rate: APIHelper.getSafeIntValue(json['rate']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'from': from.toJson(),
        'to': to.toJson(),
        '_id': id,
        'type': type,
        'user': user.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'seats': seats,
        'available': available,
        'rate': rate,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory NearestRequestsDoc.empty() => NearestRequestsDoc(
      from: NearestRequestsFrom.empty(),
      to: NearestRequestsTo.empty(),
      user: NearestRequestUser(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static NearestRequestsDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestRequestsDoc.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestRequestsDoc.empty();
}

class NearestRequestsFrom {
  NearestRequestsLocation location;
  String address;

  NearestRequestsFrom({required this.location, this.address = ''});

  factory NearestRequestsFrom.fromJson(Map<String, dynamic> json) =>
      NearestRequestsFrom(
        location: NearestRequestsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory NearestRequestsFrom.empty() => NearestRequestsFrom(
        location: NearestRequestsLocation(),
      );
  static NearestRequestsFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestRequestsFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestRequestsFrom.empty();
}

class NearestRequestsTo {
  NearestRequestsLocation location;
  String address;

  NearestRequestsTo({required this.location, this.address = ''});

  factory NearestRequestsTo.fromJson(Map<String, dynamic> json) =>
      NearestRequestsTo(
        location: NearestRequestsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'location': location.toJson(),
        'address': address,
      };

  factory NearestRequestsTo.empty() => NearestRequestsTo(
        location: NearestRequestsLocation(),
      );
  static NearestRequestsTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestRequestsTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestRequestsTo.empty();
}

class NearestRequestsLocation {
  double lat;
  double lng;

  NearestRequestsLocation({this.lat = 0, this.lng = 0});

  factory NearestRequestsLocation.fromJson(Map<String, dynamic> json) =>
      NearestRequestsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static NearestRequestsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestRequestsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestRequestsLocation();
}

class NearestRequestUser {
  String id;
  String name;
  String phone;
  String image;

  NearestRequestUser(
      {this.id = '', this.name = '', this.phone = '', this.image = ''});

  factory NearestRequestUser.fromJson(Map<String, dynamic> json) {
    return NearestRequestUser(
      id: APIHelper.getSafeStringValue(json['_id']),
      name: APIHelper.getSafeStringValue(json['name']),
      phone: APIHelper.getSafeStringValue(json['phone']),
      image: APIHelper.getSafeStringValue(json['image']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'image': image,
      };

  static NearestRequestUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestRequestUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestRequestUser();
}
