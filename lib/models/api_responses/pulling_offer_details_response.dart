import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class PullingOfferDetailsResponse {
  bool error;
  String msg;
  PullingOfferDetailsData data;

  PullingOfferDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory PullingOfferDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PullingOfferDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PullingOfferDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory PullingOfferDetailsResponse.empty() => PullingOfferDetailsResponse(
        data: PullingOfferDetailsData.empty(),
      );
  static PullingOfferDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsResponse.empty();
}

class PullingOfferDetailsData {
  String id;
  PullingOfferDetailsUser user;
  DateTime date;
  String type;
  PullingOfferDetailsFrom from;
  PullingOfferDetailsTo to;
  int seats;
  double rate;
  String status;
  DateTime createdAt;
  List<PullingOfferDetailsRequest> requests;
  List<PullingOfferDetailsRequest> pending;
  int available;
  PullingOfferDetailsCurrency currency;
  PullingOfferDetailsCategory category;
  String vehicleNumber;

  PullingOfferDetailsData({
    this.id = '',
    required this.user,
    required this.date,
    this.type = '',
    this.vehicleNumber = '',
    required this.from,
    required this.to,
    this.seats = 0,
    this.rate = 0,
    this.status = '',
    required this.createdAt,
    this.requests = const [],
    this.pending = const [],
    this.available = 0,
    required this.currency,
    required this.category,
  });

  factory PullingOfferDetailsData.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        user: PullingOfferDetailsUser.getAPIResponseObjectSafeValue(
            json['user'] as Map<String, dynamic>),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        from: PullingOfferDetailsFrom.getAPIResponseObjectSafeValue(
            json['from'] as Map<String, dynamic>),
        to: PullingOfferDetailsTo.getAPIResponseObjectSafeValue(json['to']),
        seats: APIHelper.getSafeIntValue(json['seats']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        requests: APIHelper.getSafeListValue(json['requests'])
            .map((e) =>
                PullingOfferDetailsRequest.getAPIResponseObjectSafeValue(e))
            .toList(),
        pending: APIHelper.getSafeListValue(json['pending'])
            .map((e) =>
                PullingOfferDetailsRequest.getAPIResponseObjectSafeValue(e))
            .toList(),
        available: APIHelper.getSafeIntValue(json['available']),
        category: PullingOfferDetailsCategory.getAPIResponseObjectSafeValue(
            json['category']),
        currency: PullingOfferDetailsCurrency.getAPIResponseObjectSafeValue(
            json['currency']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle_number': vehicleNumber,
        'user': user.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'from': from.toJson(),
        'to': to.toJson(),
        'seats': seats,
        'rate': rate,
        'status': status,
        'category': category.toJson(),
        'currency': currency.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'requests': requests.map((e) => e.toJson()).toList(),
        'pending': pending.map((e) => e.toJson()).toList(),
        'available': available,
      };

  factory PullingOfferDetailsData.empty() => PullingOfferDetailsData(
        currency: PullingOfferDetailsCurrency(),
        category: PullingOfferDetailsCategory(),
        user: PullingOfferDetailsUser.empty(),
        date: AppComponents.defaultUnsetDateTime,
        from: PullingOfferDetailsFrom.empty(),
        to: PullingOfferDetailsTo.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
      );
  static PullingOfferDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsData.empty();
}

class PullingOfferDetailsCategory {
  String id;
  String name;
  String image;

  PullingOfferDetailsCategory({this.id = '', this.name = '', this.image = ''});

  factory PullingOfferDetailsCategory.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static PullingOfferDetailsCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsCategory();
}

class PullingOfferDetailsTo {
  String address;
  PullingOfferDetailsLocation location;

  PullingOfferDetailsTo({this.address = '', required this.location});

  factory PullingOfferDetailsTo.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsTo(
        address: APIHelper.getSafeStringValue(json['address']),
        location: PullingOfferDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PullingOfferDetailsTo.empty() => PullingOfferDetailsTo(
        location: PullingOfferDetailsLocation(),
      );
  static PullingOfferDetailsTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsTo.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsTo.empty();
}

class PullingOfferDetailsLocation {
  double lat;
  double lng;

  PullingOfferDetailsLocation({this.lat = 0, this.lng = 0});

  factory PullingOfferDetailsLocation.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static PullingOfferDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsLocation();
}

class PullingOfferDetailsFrom {
  String address;
  PullingOfferDetailsLocation location;

  PullingOfferDetailsFrom({this.address = '', required this.location});

  factory PullingOfferDetailsFrom.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsFrom(
        address: APIHelper.getSafeStringValue(json['address']),
        location: PullingOfferDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory PullingOfferDetailsFrom.empty() => PullingOfferDetailsFrom(
        location: PullingOfferDetailsLocation(),
      );
  static PullingOfferDetailsFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsFrom.empty();
}

class PullingOfferDetailsRequest {
  String id;
  PullingOfferDetailsUser user;
  int seats;
  double rate;
  PullingOfferDetailsCategory category;
  String vehicleNumber;
  String status;
  PullingOfferDetailsCurrency currency;
  PullingOfferDetailsPayment payment;
  DateTime createdAt;

  PullingOfferDetailsRequest({
    this.id = '',
    required this.user,
    this.seats = 0,
    this.rate = 0,
    required this.category,
    this.vehicleNumber = '',
    this.status = '',
    required this.currency,
    required this.payment,
    required this.createdAt,
  });

  factory PullingOfferDetailsRequest.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsRequest(
        id: APIHelper.getSafeStringValue(json['_id']),
        user:
            PullingOfferDetailsUser.getAPIResponseObjectSafeValue(json['user']),
        seats: APIHelper.getSafeIntValue(json['seats']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        category: PullingOfferDetailsCategory.getAPIResponseObjectSafeValue(
            json['category']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        status: APIHelper.getSafeStringValue(json['status']),
        currency: PullingOfferDetailsCurrency.getAPIResponseObjectSafeValue(
            json['currency']),
        payment: PullingOfferDetailsPayment.getAPIResponseObjectSafeValue(
            json['payment']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'seats': seats,
        'rate': rate,
        'category': category,
        'vehicle_number': vehicleNumber,
        'status': status,
        'currency': currency.toJson(),
        'payment': payment.toJson(),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
      };

  factory PullingOfferDetailsRequest.empty() => PullingOfferDetailsRequest(
      user: PullingOfferDetailsUser.empty(),
      category: PullingOfferDetailsCategory(),
      currency: PullingOfferDetailsCurrency(),
      payment: PullingOfferDetailsPayment(),
      createdAt: AppComponents.defaultUnsetDateTime);
  static PullingOfferDetailsRequest getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsRequest.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsRequest.empty();
}

class PullingOfferDetailsUser {
  String id;
  String name;
  String phone;
  String email;
  String image;
  PullingOfferDetailsCategory category;

  PullingOfferDetailsUser(
      {this.id = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = '',
      required this.category});

  factory PullingOfferDetailsUser.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsUser(
          id: APIHelper.getSafeStringValue(json['_id']),
          name: APIHelper.getSafeStringValue(json['name']),
          phone: APIHelper.getSafeStringValue(json['phone']),
          email: APIHelper.getSafeStringValue(json['email']),
          image: APIHelper.getSafeStringValue(json['image']),
          category: PullingOfferDetailsCategory.getAPIResponseObjectSafeValue(
              json['category']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'category': category
      };

  factory PullingOfferDetailsUser.empty() => PullingOfferDetailsUser(
        category: PullingOfferDetailsCategory(),
      );
  static PullingOfferDetailsUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsUser.empty();
}

class PullingOfferDetailsCurrency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  PullingOfferDetailsCurrency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory PullingOfferDetailsCurrency.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsCurrency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
        rate: APIHelper.getSafeIntValue(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static PullingOfferDetailsCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsCurrency.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsCurrency();
}

class PullingOfferDetailsPayment {
  String method;
  String status;
  String transactionId;

  PullingOfferDetailsPayment(
      {this.method = '', this.status = '', this.transactionId = ''});

  factory PullingOfferDetailsPayment.fromJson(Map<String, dynamic> json) =>
      PullingOfferDetailsPayment(
        method: APIHelper.getSafeStringValue(json['method']),
        status: APIHelper.getSafeStringValue(json['status']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
      );

  Map<String, dynamic> toJson() => {
        'method': method,
        'status': status,
        'transaction_id': transactionId,
      };

  static PullingOfferDetailsPayment getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PullingOfferDetailsPayment.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PullingOfferDetailsPayment();
}
