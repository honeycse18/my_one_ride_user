import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class RentVehicleListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<RentCarListItem> data;

  RentVehicleListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory RentVehicleListResponse.fromJson(Map<String, dynamic> json) {
    return RentVehicleListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            RentCarListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory RentVehicleListResponse.empty() =>
      RentVehicleListResponse(data: PaginatedDataResponse.empty());
  static RentVehicleListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentVehicleListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentVehicleListResponse.empty();
}

class RentCarListItem {
  String id;
  String uid;
  Vehicle vehicle;
  bool hasDriver;
  Driver driver;
  Prices prices;
  String address;
  RentcarLocation location;
  Facilities facilities;
  bool active;
  bool isMonthlySelected;
  bool isWeeklySelected;
  bool isHourlySelected;

  RentCarListItem({
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
    this.isMonthlySelected = false,
    this.isWeeklySelected = false,
    this.isHourlySelected = false,
  });

  factory RentCarListItem.fromJson(Map<String, dynamic> json) =>
      RentCarListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        hasDriver: APIHelper.getSafeBoolValue(json['has_driver']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        prices: Prices.getAPIResponseObjectSafeValue(json['prices']),
        address: APIHelper.getSafeStringValue(json['address']),
        location:
            RentcarLocation.getAPIResponseObjectSafeValue(json['location']),
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
        active: APIHelper.getSafeBoolValue(json['active']),
        isHourlySelected: APIHelper.getSafeBoolValue(json['isHourlySelected']),
        isWeeklySelected: APIHelper.getSafeBoolValue(json['isWeeklySelected']),
        isMonthlySelected:
            APIHelper.getSafeBoolValue(json['isMonthlySelected']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'vehicle': vehicle.toJson(),
        'has_driver': hasDriver,
        'driver': driver.toJson(),
        'prices': prices.toJson(),
        'address': address,
        'location': location.toJson(),
        'facilities': facilities.toJson(),
        'active': active,
        'isHourlySelected': isHourlySelected,
        'isWeeklySelected': isWeeklySelected,
        'isMonthlySelected': isMonthlySelected,
      };

  factory RentCarListItem.empty() => RentCarListItem(
        driver: Driver(),
        facilities: Facilities(),
        location: RentcarLocation(),
        prices: Prices.empty(),
        vehicle: Vehicle.empty(),
      );
  static RentCarListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentCarListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentCarListItem.empty();
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
  String gearType;
  int mileage;
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
    this.gearType = '',
    this.mileage = 0,
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
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
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
        'gear_type': gearType,
        'mileage': mileage,
        'ac': ac,
      };

  factory Vehicle.empty() => Vehicle(category: Category());
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
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
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

class Driver {
  String id;
  String name;
  String phone;
  String email;

  Driver({this.id = '', this.name = '', this.phone = '', this.email = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}

class RentcarLocation {
  double lat;
  double lng;

  RentcarLocation({this.lat = 0, this.lng = 0});

  factory RentcarLocation.fromJson(Map<String, dynamic> json) =>
      RentcarLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static RentcarLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentcarLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentcarLocation();
}

class Facilities {
  bool smoking;
  int luggage;

  Facilities({this.smoking = false, this.luggage = 0});

  factory Facilities.fromJson(Map<String, dynamic> json) => Facilities(
        smoking: json['smoking'] as bool,
        luggage: json['luggage'] as int,
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
        'hourly': hourly.toJson(),
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
