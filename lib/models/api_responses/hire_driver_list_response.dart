import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class HireDriverListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<HireDriverListItem> data;

  HireDriverListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory HireDriverListResponse.fromJson(Map<String, dynamic> json) {
    return HireDriverListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            HireDriverListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory HireDriverListResponse.empty() =>
      HireDriverListResponse(data: PaginatedDataResponse.empty());
  static HireDriverListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireDriverListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HireDriverListResponse.empty();
}

class HireDriverListItem {
  Start start;
  End end;
  Currency currency;
  String id;
  String uid;
  HireBy hireBy;
  Driver driver;
  String pickup;
  String otp;
  String destination;
  double amount;
  String type;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  HireDriverListItem({
    required this.start,
    required this.end,
    this.id = '',
    this.uid = '',
    required this.hireBy,
    required this.currency,
    required this.driver,
    this.pickup = '',
    this.destination = '',
    this.amount = 0,
    this.type = '',
    this.otp = '',
    this.status = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory HireDriverListItem.fromJson(Map<String, dynamic> json) =>
      HireDriverListItem(
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        start: Start.getAPIResponseObjectSafeValue(json['start']),
        end: End.getAPIResponseObjectSafeValue(json['end']),
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        hireBy: HireBy.getAPIResponseObjectSafeValue(json['hire_by']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        pickup: APIHelper.getSafeStringValue(json['pickup']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        destination: APIHelper.getSafeStringValue(json['destination']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        type: APIHelper.getSafeStringValue(json['type']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'start': start.toJson(),
        'end': end.toJson(),
        '_id': id,
        'uid': uid,
        'otp': otp,
        'hire_by': hireBy.toJson(),
        'driver': driver.toJson(),
        'pickup': pickup,
        'destination': destination,
        'amount': amount,
        'type': type,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory HireDriverListItem.empty() => HireDriverListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        currency: Currency(),
        end: End.empty(),
        hireBy: HireBy(),
        start: Start.empty(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static HireDriverListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireDriverListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HireDriverListItem.empty();
}

class HireBy {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  HireBy({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory HireBy.fromJson(Map<String, dynamic> json) => HireBy(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static HireBy getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireBy.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : HireBy();
}

class Start {
  DateTime date;
  DateTime time;

  Start({required this.date, required this.time});

  factory Start.fromJson(Map<String, dynamic> json) => Start(
        date: APIHelper.getSafeDateTimeValue(json['date'],
            dateTimeFormat: AppComponents.apiOnlyDateFormat, isUTCTime: false),
        time: APIHelper.getSafeDateTimeValue(json['time'],
            dateTimeFormat: AppComponents.apiOnlyTimeFormat, isUTCTime: false),
      );

  Map<String, dynamic> toJson() => {
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'time': APIHelper.toServerDateTimeFormattedStringFromDateTime(time),
      };

  factory Start.empty() => Start(
      date: AppComponents.defaultUnsetDateTime,
      time: AppComponents.defaultUnsetDateTime);
  static Start getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Start.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Start.empty();
}

class End {
  DateTime date;
  DateTime time;

  End({required this.date, required this.time});

  factory End.fromJson(Map<String, dynamic> json) => End(
        date: APIHelper.getSafeDateTimeValue(json['date'],
            dateTimeFormat: AppComponents.apiOnlyDateFormat, isUTCTime: false),
        time: APIHelper.getSafeDateTimeValue(json['time'],
            dateTimeFormat: AppComponents.apiOnlyTimeFormat, isUTCTime: false),
      );

  Map<String, dynamic> toJson() => {
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'time': APIHelper.toServerDateTimeFormattedStringFromDateTime(time),
      };

  factory End.empty() => End(
      date: AppComponents.defaultUnsetDateTime,
      time: AppComponents.defaultUnsetDateTime);
  static End getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? End.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : End.empty();
}

class Driver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  Driver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}
