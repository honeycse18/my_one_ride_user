/* import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class RideRequestResponse {
  bool error;
  String msg;
  RideRequestData data;

  RideRequestResponse({this.error = false, this.msg = '', required this.data});

  factory RideRequestResponse.fromJson(Map<String, dynamic> json) {
    return RideRequestResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RideRequestData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RideRequestResponse.empty() => RideRequestResponse(
        data: RideRequestData.empty(),
      );
  static RideRequestResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestResponse.empty();
}

class RideRequestData {
  RideRequestDriver driver;
  RideRequestUser user;
  RideRequestRide ride;
  RideRequestFrom from;
  RideRequestTo to;
  RideRequestDistance distance;
  RideRequestDuration duration;
  double total;
  String id;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RideRequestData({
    required this.driver,
    required this.user,
    required this.ride,
    required this.from,
    required this.to,
    required this.distance,
    required this.duration,
    this.total = 0,
    this.id = '',
    required this.expireAt,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory RideRequestData.fromJson(Map<String, dynamic> json) =>
      RideRequestData(
        driver: RideRequestDriver.getAPIResponseObjectSafeValue(json['driver']),
        user: RideRequestUser.getAPIResponseObjectSafeValue(json['user']),
        ride: RideRequestRide.getAPIResponseObjectSafeValue(json['ride']),
        from: RideRequestFrom.getAPIResponseObjectSafeValue(json['from']),
        to: RideRequestTo.getAPIResponseObjectSafeValue(json['to']),
        distance:
            RideRequestDistance.getAPIResponseObjectSafeValue(json['distance']),
        duration:
            RideRequestDuration.getAPIResponseObjectSafeValue(json['duration']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        id: APIHelper.getSafeStringValue(json['_id']),
        expireAt: APIHelper.getSafeDateTimeValue(json['expireAt']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        'driver': driver.toJson(),
        'user': user.toJson(),
        'ride': ride.toJson(),
        'from': from.toJson(),
        'to': to.toJson(),
        'distance': distance.toJson(),
        'duration': duration.toJson(),
        'total': total,
        '_id': id,
        'expireAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(expireAt),
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory RideRequestData.empty() => RideRequestData(
        driver: RideRequestDriver(),
        user: RideRequestUser(),
        ride: RideRequestRide.empty(),
        from: RideRequestFrom.empty(),
        to: RideRequestTo.empty(),
        distance: RideRequestDistance(),
        duration: RideRequestDuration(),
        expireAt: AppComponents.defaultUnsetDateTime,
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static RideRequestData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestData.empty();
}

class RideRequestDistance {
  String text;
  int value;

  RideRequestDistance({this.text = '', this.value = 0});

  factory RideRequestDistance.fromJson(Map<String, dynamic> json) =>
      RideRequestDistance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideRequestDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestDistance();
}

class RideRequestDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideRequestDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory RideRequestDriver.fromJson(Map<String, dynamic> json) =>
      RideRequestDriver(
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

  static RideRequestDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestDriver();
}

class RideRequestDuration {
  String text;
  int value;

  RideRequestDuration({this.text = '', this.value = 0});

  factory RideRequestDuration.fromJson(Map<String, dynamic> json) =>
      RideRequestDuration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static RideRequestDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestDuration();
}

class RideRequestFrom {
  String address;
  RideRequestLocation location;

  RideRequestFrom({this.address = '', required this.location});

  factory RideRequestFrom.fromJson(Map<String, dynamic> json) =>
      RideRequestFrom(
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            RideRequestLocation.getAPIResponseObjectSafeValue(json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory RideRequestFrom.empty() => RideRequestFrom(
        location: RideRequestLocation(),
      );
  static RideRequestFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestFrom.empty();
}

class RideRequestLocation {
  double lat;
  double lng;

  RideRequestLocation({this.lat = 0, this.lng = 0});

  factory RideRequestLocation.fromJson(Map<String, dynamic> json) =>
      RideRequestLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RideRequestLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestLocation();
}

class RideRequestTo {
  String address;
  RideRequestLocation location;

  RideRequestTo({this.address = '', required this.location});

  factory RideRequestTo.fromJson(Map<String, dynamic> json) => RideRequestTo(
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            RideRequestLocation.getAPIResponseObjectSafeValue(json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory RideRequestTo.empty() => RideRequestTo(
        location: RideRequestLocation(),
      );
  static RideRequestTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : RideRequestTo.empty();
}

class RideRequestRide {
  String id;
  RideRequestVehicle vehicle;

  RideRequestRide({this.id = '', required this.vehicle});

  factory RideRequestRide.fromJson(Map<String, dynamic> json) =>
      RideRequestRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle:
            RideRequestVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory RideRequestRide.empty() => RideRequestRide(
        vehicle: RideRequestVehicle(),
      );
  static RideRequestRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestRide.empty();
}

class RideRequestVehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  RideRequestVehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory RideRequestVehicle.fromJson(Map<String, dynamic> json) =>
      RideRequestVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        model: APIHelper.getSafeStringValue(json['model']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  static RideRequestVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestVehicle();
}

class RideRequestUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  RideRequestUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory RideRequestUser.fromJson(Map<String, dynamic> json) =>
      RideRequestUser(
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

  static RideRequestUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RideRequestUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RideRequestUser();
}
 */
