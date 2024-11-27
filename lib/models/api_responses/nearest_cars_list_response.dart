import 'package:one_ride_user/utils/helpers/api_helper.dart';

class NearestCarsListResponse {
  bool error;
  String msg;
  NearestCarsListData data;

  NearestCarsListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory NearestCarsListResponse.fromJson(Map<String, dynamic> json) {
    return NearestCarsListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: NearestCarsListData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory NearestCarsListResponse.empty() => NearestCarsListResponse(
        data: NearestCarsListData(),
      );
  static NearestCarsListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListResponse.empty();
}

class NearestCarsListData {
  List<NearestCarsListRide> rides;
  List<NearestCarsListCategory> categories;

  NearestCarsListData({this.rides = const [], this.categories = const []});

  factory NearestCarsListData.fromJson(Map<String, dynamic> json) =>
      NearestCarsListData(
        rides: APIHelper.getSafeListValue(json['rides'])
            .map((e) => NearestCarsListRide.getAPIResponseObjectSafeValue(e))
            .toList(),
        categories: APIHelper.getSafeListValue(json['categories'])
            .map(
                (e) => NearestCarsListCategory.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'rides': rides.map((e) => e.toJson()).toList(),
        'categories': categories.map((e) => e.toJson()).toList(),
      };

  static NearestCarsListData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListData();
}

class NearestCarsListCategory {
  String id;
  String name;
  String image;

  NearestCarsListCategory({this.id = '', this.name = '', this.image = ''});

  factory NearestCarsListCategory.fromJson(Map<String, dynamic> json) =>
      NearestCarsListCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'image': image};

  static NearestCarsListCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListCategory();
}

class NearestCarsListVehicleCategory {
  String id;
  String name;
  String uid;

  NearestCarsListVehicleCategory({this.id = '', this.name = '', this.uid = ''});

  factory NearestCarsListVehicleCategory.fromJson(Map<String, dynamic> json) =>
      NearestCarsListVehicleCategory(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        uid: APIHelper.getSafeStringValue(json['uid']),
      );

  Map<String, dynamic> toJson() => {'_id': id, 'name': name, 'uid': uid};

  static NearestCarsListVehicleCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListVehicleCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListVehicleCategory();
}

class NearestCarsListRide {
  String id;
  NearestCarsListVehicle vehicle;
  NearestCarsListDriver driver;
  NearestCarsListLocation location;
  NearestCarsListDistanceTime distance;
  NearestCarsListDistanceTime time;
  double total;

  NearestCarsListRide(
      {this.id = '',
      required this.vehicle,
      required this.driver,
      required this.location,
      required this.distance,
      required this.time,
      this.total = 0});

  factory NearestCarsListRide.fromJson(Map<String, dynamic> json) =>
      NearestCarsListRide(
          id: APIHelper.getSafeStringValue(json['_id']),
          vehicle: NearestCarsListVehicle.getAPIResponseObjectSafeValue(
              json['vehicle']),
          driver: NearestCarsListDriver.getAPIResponseObjectSafeValue(
              json['driver']),
          location: NearestCarsListLocation.getAPIResponseObjectSafeValue(
              json['location']),
          distance: NearestCarsListDistanceTime.getAPIResponseObjectSafeValue(
              json['distance']),
          time: NearestCarsListDistanceTime.getAPIResponseObjectSafeValue(
              json['time']),
          total: APIHelper.getSafeDoubleValue(json['total'], 0));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'vehicle': vehicle.toJson(),
        'driver': driver.toJson(),
        'location': location.toJson(),
        'distance': distance.toJson(),
        'time': time.toJson(),
        'total': total
      };

  factory NearestCarsListRide.empty() => NearestCarsListRide(
      vehicle: NearestCarsListVehicle.empty(),
      driver: NearestCarsListDriver.empty(),
      location: NearestCarsListLocation(),
      distance: NearestCarsListDistanceTime(),
      time: NearestCarsListDistanceTime());
  static NearestCarsListRide getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListRide.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListRide.empty();
}

class NearestCarsListDriver {
  String id;
  String uid;
  String name;
  String phone;
  String image;
  double lat;
  double lng;
  NearestCarsListDistanceTime distance;
  NearestCarsListDistanceTime time;

  NearestCarsListDriver(
      {this.id = '',
      this.uid = '',
      this.name = '',
      this.phone = '',
      this.image = '',
      this.lat = 0,
      this.lng = 0,
      required this.distance,
      required this.time});

  factory NearestCarsListDriver.fromJson(Map<String, dynamic> json) =>
      NearestCarsListDriver(
          id: APIHelper.getSafeStringValue(json['_id']),
          uid: APIHelper.getSafeStringValue(json['uid']),
          name: APIHelper.getSafeStringValue(json['name']),
          phone: APIHelper.getSafeStringValue(json['phone']),
          image: APIHelper.getSafeStringValue(json['image']),
          lat: APIHelper.getSafeDoubleValue(json['lat']),
          lng: APIHelper.getSafeDoubleValue(json['lng']),
          distance: NearestCarsListDistanceTime.getAPIResponseObjectSafeValue(
              json['distance']),
          time: NearestCarsListDistanceTime.getAPIResponseObjectSafeValue(
              json['time']));

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'image': image,
        'lat': lat,
        'lng': lng,
        'distance': distance.toJson(),
        'time': time.toJson()
      };

  factory NearestCarsListDriver.empty() => NearestCarsListDriver(
      distance: NearestCarsListDistanceTime(),
      time: NearestCarsListDistanceTime());
  static NearestCarsListDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListDriver.empty();
}

class NearestCarsListLocation {
  double lat;
  double lng;

  NearestCarsListLocation({this.lat = 0, this.lng = 0});

  factory NearestCarsListLocation.fromJson(Map<String, dynamic> json) =>
      NearestCarsListLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static NearestCarsListLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListLocation();
}

class NearestCarsListVehicle {
  String id;
  String uid;
  String name;
  NearestCarsListVehicleCategory category;
  String model;
  List<String> images;
  int capacity;
  String color;

  NearestCarsListVehicle({
    this.id = '',
    this.uid = '',
    this.name = '',
    required this.category,
    this.model = '',
    this.images = const [],
    this.capacity = 0,
    this.color = '',
  });

  factory NearestCarsListVehicle.fromJson(Map<String, dynamic> json) =>
      NearestCarsListVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: NearestCarsListVehicleCategory.getAPIResponseObjectSafeValue(
            json['category']),
        model: APIHelper.getSafeStringValue(json['model']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'category': category.toJson(),
        'model': model,
        'images': images,
        'capacity': capacity,
        'color': color,
      };

  factory NearestCarsListVehicle.empty() => NearestCarsListVehicle(
        category: NearestCarsListVehicleCategory(),
      );
  static NearestCarsListVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListVehicle.empty();
}

class NearestCarsListDistanceTime {
  String text;
  double value;

  NearestCarsListDistanceTime({this.text = '', this.value = 0});

  factory NearestCarsListDistanceTime.fromJson(Map<String, dynamic> json) =>
      NearestCarsListDistanceTime(
        text: APIHelper.getSafeStringValue(json['text']),
        value: APIHelper.getSafeDoubleValue(json['value']),
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'value': value,
      };

  static NearestCarsListDistanceTime getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? NearestCarsListDistanceTime.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : NearestCarsListDistanceTime();
}
