import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class ScheduleRideResponse {
  bool error;
  String msg;
  ScheduleRideData data;

  ScheduleRideResponse({this.error = false, this.msg = '', required this.data});

  factory ScheduleRideResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleRideResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ScheduleRideData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ScheduleRideResponse.empty() => ScheduleRideResponse(
        data: ScheduleRideData.empty(),
      );
  static ScheduleRideResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideResponse.empty();
}

class ScheduleRideData {
  ScheduleRideDriver driver;
  ScheduleRideUser user;
  ScheduleRideRide ride;
  DateTime date;
  bool schedule;
  ScheduleRideFrom from;
  ScheduleRideTo to;
  ScheduleRideDistance distance;
  ScheduleRideDuration duration;
  double total;
  String id;
  DateTime expireAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ScheduleRideData({
    required this.driver,
    required this.user,
    required this.ride,
    required this.date,
    this.schedule = false,
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

  factory ScheduleRideData.fromJson(Map<String, dynamic> json) =>
      ScheduleRideData(
        driver:
            ScheduleRideDriver.getAPIResponseObjectSafeValue(json['driver']),
        user: ScheduleRideUser.getAPIResponseObjectSafeValue(json['user']),
        ride: ScheduleRideRide.getAPIResponseObjectSafeValue(json['ride']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        schedule: APIHelper.getSafeBoolValue(json['schedule']),
        from: ScheduleRideFrom.getAPIResponseObjectSafeValue(json['from']),
        to: ScheduleRideTo.getAPIResponseObjectSafeValue(json['to']),
        distance: ScheduleRideDistance.getAPIResponseObjectSafeValue(
            json['distance']),
        duration: ScheduleRideDuration.getAPIResponseObjectSafeValue(
            json['duration']),
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
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'schedule': schedule,
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

  factory ScheduleRideData.empty() => ScheduleRideData(
        driver: ScheduleRideDriver(),
        user: ScheduleRideUser(),
        ride: ScheduleRideRide.empty(),
        date: AppComponents.defaultUnsetDateTime,
        from: ScheduleRideFrom.empty(),
        to: ScheduleRideTo.empty(),
        distance: ScheduleRideDistance(),
        duration: ScheduleRideDuration(),
        expireAt: AppComponents.defaultUnsetDateTime,
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static ScheduleRideData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideData.empty();
}

class ScheduleRideDistance {
  String text;
  int value;

  ScheduleRideDistance({this.text = '', this.value = 0});

  factory ScheduleRideDistance.fromJson(Map<String, dynamic> json) =>
      ScheduleRideDistance(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static ScheduleRideDistance getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideDistance.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideDistance();
}

class ScheduleRideDriver {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  ScheduleRideDriver({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
  });

  factory ScheduleRideDriver.fromJson(Map<String, dynamic> json) =>
      ScheduleRideDriver(
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

  static ScheduleRideDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideDriver();
}

class ScheduleRideDuration {
  String text;
  int value;

  ScheduleRideDuration({this.text = '', this.value = 0});

  factory ScheduleRideDuration.fromJson(Map<String, dynamic> json) =>
      ScheduleRideDuration(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeIntValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static ScheduleRideDuration getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideDuration.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideDuration();
}

class ScheduleRideFrom {
  String address;
  ScheduleRideLocation location;

  ScheduleRideFrom({this.address = '', required this.location});

  factory ScheduleRideFrom.fromJson(Map<String, dynamic> json) =>
      ScheduleRideFrom(
        address: APIHelper.getSafeStringValue(json['address']),
        location: ScheduleRideLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory ScheduleRideFrom.empty() => ScheduleRideFrom(
        location: ScheduleRideLocation(),
      );
  static ScheduleRideFrom getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideFrom.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideFrom.empty();
}

class ScheduleRideLocation {
  double lat;
  double lng;

  ScheduleRideLocation({this.lat = 0, this.lng = 0});

  factory ScheduleRideLocation.fromJson(Map<String, dynamic> json) =>
      ScheduleRideLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static ScheduleRideLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideLocation();
}

class ScheduleRideTo {
  String address;
  ScheduleRideLocation location;

  ScheduleRideTo({this.address = '', required this.location});

  factory ScheduleRideTo.fromJson(Map<String, dynamic> json) => ScheduleRideTo(
        address: APIHelper.getSafeStringValue(json['address']),
        location: ScheduleRideLocation.getAPIResponseObjectSafeValue(
            json['location']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'location': location.toJson(),
      };

  factory ScheduleRideTo.empty() => ScheduleRideTo(
        location: ScheduleRideLocation(),
      );
  static ScheduleRideTo getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideTo.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideTo.empty();
}

class ScheduleRideRide {
  String id;
  ScheduleRideVehicle vehicle;

  ScheduleRideRide({this.id = '', required this.vehicle});

  factory ScheduleRideRide.fromJson(Map<String, dynamic> json) =>
      ScheduleRideRide(
        id: APIHelper.getSafeStringValue(json['_id']),
        vehicle:
            ScheduleRideVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
      };

  factory ScheduleRideRide.empty() => ScheduleRideRide(
        vehicle: ScheduleRideVehicle(),
      );
  static ScheduleRideRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideRide.empty();
}

class ScheduleRideVehicle {
  String id;
  String name;
  String model;
  List<String> images;
  int capacity;
  String color;

  ScheduleRideVehicle({
    this.id = '',
    this.name = '',
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory ScheduleRideVehicle.fromJson(Map<String, dynamic> json) =>
      ScheduleRideVehicle(
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

  static ScheduleRideVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideVehicle();
}

class ScheduleRideUser {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;

  ScheduleRideUser(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory ScheduleRideUser.fromJson(Map<String, dynamic> json) =>
      ScheduleRideUser(
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

  static ScheduleRideUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ScheduleRideUser.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ScheduleRideUser();
}
