import 'package:one_ride_user/utils/helpers/api_helper.dart';

class CarRentDetailsResponse {
  bool error;
  String msg;
  CarRentItem data;

  CarRentDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory CarRentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return CarRentDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: CarRentItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory CarRentDetailsResponse.empty() => CarRentDetailsResponse(
        data: CarRentItem.empty(),
      );
  static CarRentDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarRentDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarRentDetailsResponse.empty();
}

class CarRentItem {
  String id;
  String uid;
  Vehicle vehicle;
  bool hasDriver;
  Driver driver;
  Owner owner;
  Prices prices;
  String address;
  Location location;
  Facilities facilities;
  bool active;

  CarRentItem({
    this.id = '',
    this.uid = '',
    required this.vehicle,
    this.hasDriver = false,
    required this.driver,
    required this.prices,
    this.address = '',
    required this.location,
    required this.facilities,
    this.active = false,
    required this.owner,
  });

  factory CarRentItem.fromJson(Map<String, dynamic> json) => CarRentItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        hasDriver: APIHelper.getSafeBoolValue(json['has_driver']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        prices: Prices.getAPIResponseObjectSafeValue(json['prices']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: Location.getAPIResponseObjectSafeValue(json['location']),
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
        active: APIHelper.getSafeBoolValue(json['active']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'vehicle': vehicle.toJson(),
        'has_driver': hasDriver,
        'driver': driver.toJson(),
        'owner': driver.toJson(),
        'prices': prices.toJson(),
        'address': address,
        'location': location.toJson(),
        'facilities': facilities.toJson(),
        'active': active,
      };

  factory CarRentItem.empty() => CarRentItem(
        driver: Driver(),
        facilities: Facilities(),
        location: Location(),
        owner: Owner(),
        prices: Prices.empty(),
        vehicle: Vehicle.empty(),
      );
  static CarRentItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarRentItem.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : CarRentItem.empty();
}

class Vehicle {
  String uid;
  String name;
  Category category;
  String model;
  String year;
  List<String> images;
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  String vehicleNumber;
  int mileage;
  String gearType;
  bool ac;

  Vehicle({
    this.uid = '',
    this.name = '',
    required this.category,
    this.model = '',
    this.year = '',
    this.images = const [],
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.vehicleNumber = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        model: APIHelper.getSafeStringValue(json['model']),
        year: APIHelper.getSafeStringValue(json['year']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        maxPower: APIHelper.getSafeStringValue(json['max_power']),
        maxSpeed: APIHelper.getSafeStringValue(json['max_speed']),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
        fuelType: APIHelper.getSafeStringValue(json['fuel_type']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        ac: APIHelper.getSafeBoolValue(json['ac']),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'category': category.toJson(),
        'model': model,
        'year': year,
        'images': images,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'vehicle_number': vehicleNumber,
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
      };

  factory Vehicle.empty() => Vehicle(
        category: Category(),
      );
  static Vehicle getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Vehicle.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Vehicle.empty();
}

class Category {
  String id;
  String name;
  String image;

  Category({this.id = '', this.name = '', this.image = ''});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['_id'] as String,
        name: json['name'] as String,
        image: json['image'] as String,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category();
}

class Driver {
  String id;
  String name;
  String image;
  String phone;
  String email;

  Driver(
      {this.id = '',
      this.name = '',
      this.phone = '',
      this.email = '',
      this.image = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
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

class Owner {
  String id;
  String name;
  String image;
  String email;

  Owner({this.id = '', this.name = '', this.email = '', this.image = ''});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'image': image,
      };

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
}

class Location {
  double lat;
  double lng;

  Location({this.lat = 0, this.lng = 0});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static Location getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Location.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Location();
}

class Prices {
  Hourly hourly;
  Weekly weekly;
  Monthly monthly;

  Prices({required this.hourly, required this.weekly, required this.monthly});

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        hourly: Hourly.getAPIResponseObjectSafeValue(json['hourly']),
        weekly: Weekly.getAPIResponseObjectSafeValue(json['weekly']),
        monthly: Monthly.getAPIResponseObjectSafeValue(json['monthly']),
      );

  Map<String, dynamic> toJson() => {
        'daily': hourly.toJson(),
        'weekly': weekly.toJson(),
        'monthly': monthly.toJson(),
      };

  factory Prices.empty() => Prices(
        hourly: Hourly(),
        monthly: Monthly(),
        weekly: Weekly(),
      );
  static Prices getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Prices.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Prices.empty();
}

class Hourly {
  bool active;
  double price;

  Hourly({this.active = false, this.price = 0});

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Hourly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Hourly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Hourly();
}

class Weekly {
  bool active;
  double price;

  Weekly({this.active = false, this.price = 0});

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Weekly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Weekly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Weekly();
}

class Monthly {
  bool active;
  double price;

  Monthly({this.active = false, this.price = 0});

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
        active: APIHelper.getSafeBoolValue(json['active']),
        price: APIHelper.getSafeDoubleValue(json['price']),
      );

  Map<String, dynamic> toJson() => {
        'active': active,
        'price': price,
      };

  static Monthly getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Monthly.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Monthly();
}

class Facilities {
  bool smoking;
  int luggage;

  Facilities({this.smoking = false, this.luggage = 0});

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: APIHelper.getSafeBoolValue(json['smoking']),
        luggage: APIHelper.getSafeIntValue(json['luggage']),
      );

  Map<String, dynamic> toJson() => {
        'smoking': smoking,
        'luggage': luggage,
      };

  static Facilities getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Facilities.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Facilities();
}
