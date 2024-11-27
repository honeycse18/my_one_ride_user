import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class CarRentListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<CarRentListItem> data;

  CarRentListResponse({this.error = false, this.msg = '', required this.data});

  factory CarRentListResponse.fromJson(Map<String, dynamic> json) {
    return CarRentListResponse(
      error: json['error'] as bool,
      msg: json['msg'] as String,
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            CarRentListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory CarRentListResponse.empty() => CarRentListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static CarRentListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarRentListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarRentListResponse.empty();
}

class CarRentListItem {
  String id;
  User user;
  Rent rent;
  Vehicle vehicle;
  Owner owner;
  Driver driver;
  DateTime date;
  String type;
  double rate;
  int quantity;
  double total;
  String paymentMethod;
  String status;
  bool paid;
  DateTime createdAt;
  DateTime updatedAt;

  CarRentListItem({
    this.id = '',
    required this.user,
    required this.rent,
    required this.vehicle,
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.paymentMethod = '',
    this.status = '',
    this.paid = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarRentListItem.fromJson(Map<String, dynamic> json) =>
      CarRentListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        rent: Rent.getAPIResponseObjectSafeValue(json['rent']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        paid: APIHelper.getSafeBoolValue(json['paid']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'rent': rent.toJson(),
        'vehicle': vehicle.toJson(),
        'owner': owner.toJson(),
        'driver': driver,
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'payment_method': paymentMethod,
        'status': status,
        'paid': paid,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory CarRentListItem.empty() => CarRentListItem(
        rent: Rent.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        date: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        owner: Owner(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: User(),
        vehicle: Vehicle.empty(),
      );
  static CarRentListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? CarRentListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : CarRentListItem.empty();
}

class Driver {
  String id;
  String uid;
  String name;
  String image;

  Driver({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Driver getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Driver.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Driver();
}

class Owner {
  String id;
  String uid;
  String name;
  String image;

  Owner({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
}

class User {
  String id;
  String uid;
  String name;
  String image;

  User({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class Rent {
  Facilities facilities;
  String id;
  String address;

  Rent({required this.facilities, this.id = '', this.address = ''});

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
        facilities:
            Facilities.getAPIResponseObjectSafeValue(json['facilities']),
        id: APIHelper.getSafeStringValue(json['_id']),
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'facilities': facilities.toJson(),
        '_id': id,
        'address': address,
      };

  factory Rent.empty() => Rent(
        facilities: Facilities(),
      );
  static Rent getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Rent.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Rent.empty();
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

class Vehicle {
  String id;
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
  int mileage;
  String gearType;
  bool ac;
  String vehicleNumber;

  Vehicle({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.images = const [],
    required this.category,
    this.model = '',
    this.year = '',
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
    this.vehicleNumber = '',
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        model: APIHelper.getSafeStringValue(json['model']),
        year: APIHelper.getSafeStringValue(json['year']),
        maxPower: APIHelper.getSafeStringValue(json['max_power']),
        maxSpeed: APIHelper.getSafeStringValue(json['max_speed']),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        color: APIHelper.getSafeStringValue(json['color']),
        fuelType: APIHelper.getSafeStringValue(json['fuel_type']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        ac: APIHelper.getSafeBoolValue(json['ac']),
        vehicleNumber: APIHelper.getSafeStringValue(json['vehicle_number']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
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
        'mileage': mileage,
        'gear_type': gearType,
        'ac': ac,
        'vehicle_number': vehicleNumber,
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
  String uid;
  String name;
  String image;

  Category({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'image': image,
      };

  static Category getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Category.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Category();
}
