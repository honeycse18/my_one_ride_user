import 'package:one_ride_user/models/api_responses/user_details_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class HireDriverDetailsResponse {
  bool error;
  String msg;
  HireDriverListItem data;

  HireDriverDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory HireDriverDetailsResponse.fromJson(Map<String, dynamic> json) {
    return HireDriverDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: HireDriverListItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory HireDriverDetailsResponse.empty() => HireDriverDetailsResponse(
        data: HireDriverListItem.empty(),
      );
  static HireDriverDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireDriverDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HireDriverDetailsResponse.empty();
}

class HireDriverListItem {
  Start start;
  String review;
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
  int time;
  Payment payment;

  DateTime startTime;
  DateTime createdAt;
  DateTime updatedAt;

  HireDriverListItem({
    required this.currency,
    required this.start,
    required this.end,
    this.id = '',
    this.review = '',
    this.uid = '',
    required this.hireBy,
    required this.driver,
    this.pickup = '',
    this.otp = '',
    this.destination = '',
    this.amount = 0,
    this.time = 0,
    this.type = '',
    this.status = '',
    required this.payment,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HireDriverListItem.fromJson(Map<String, dynamic> json) =>
      HireDriverListItem(
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        start: Start.getAPIResponseObjectSafeValue(json['start']),
        end: End.getAPIResponseObjectSafeValue(json['end']),
        id: APIHelper.getSafeStringValue(json['_id']),
        review: APIHelper.getSafeStringValue(json['review']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        hireBy: HireBy.getAPIResponseObjectSafeValue(json['hire_by']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        pickup: APIHelper.getSafeStringValue(json['pickup']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        destination: APIHelper.getSafeStringValue(json['destination']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        type: APIHelper.getSafeStringValue(json['type']),
        status: APIHelper.getSafeStringValue(json['status']),
        time: APIHelper.getSafeIntValue(json['time']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        startTime: APIHelper.getSafeDateTimeValue(json['startTime']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'start': start.toJson(),
        'end': end.toJson(),
        '_id': id,
        'review': review,
        'uid': uid,
        'otp': otp,
        'hire_by': hireBy.toJson(),
        'driver': driver.toJson(),
        'pickup': pickup,
        'destination': destination,
        'amount': amount,
        'type': type,
        'payment': payment,
        'time': time,
        'status': status,
        'startTime':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(startTime),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory HireDriverListItem.empty() => HireDriverListItem(
        currency: Currency(),
        payment: Payment(),
        createdAt: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        end: End.empty(),
        hireBy: HireBy(),
        start: Start.empty(),
        startTime: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static HireDriverListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? HireDriverListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : HireDriverListItem.empty();

  Duration get timeDuration => Duration(seconds: time);
}

class Payment {
  String method;
  String status;
  String transactionId;
  double amount;

  Payment(
      {this.method = '',
      this.status = '',
      this.transactionId = '',
      this.amount = 0});

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        method: APIHelper.getSafeStringValue(json['method']),
        status: APIHelper.getSafeStringValue(json['status']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
        'amount': amount,
      };

  static Payment getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Payment.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Payment();
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
