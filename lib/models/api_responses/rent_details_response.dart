import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class RentDetailsResponse {
  bool error;
  String msg;
  RentDetailsItem data;

  RentDetailsResponse({this.error = false, this.msg = '', required this.data});

  factory RentDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RentDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: RentDetailsItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory RentDetailsResponse.empty() =>
      RentDetailsResponse(data: RentDetailsItem.empty());
  static RentDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsResponse.empty();
}

class RentDetailsItem {
  Payment payment;
  User user;
  Rent rent;
  Vehicle vehicle;
  Owner owner;
  Driver driver;
  DateTime date;
  String type;
  String otp;
  double rate;
  int quantity;
  double total;
  String status;
  Currency currency;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  RentDetailsItem({
    required this.payment,
    required this.user,
    required this.rent,
    required this.vehicle,
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.otp = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.status = '',
    required this.currency,
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory RentDetailsItem.fromJson(Map<String, dynamic> json) =>
      RentDetailsItem(
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        user: User.getAPIResponseObjectSafeValue(json['user']),
        rent: Rent.getAPIResponseObjectSafeValue(json['rent']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        status: APIHelper.getSafeStringValue(json['status']),
        currency: Currency.fromJson(json['currency']),
        id: APIHelper.getSafeStringValue(json['_id']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'payment': payment.toJson(),
        'user': user.toJson(),
        'rent': rent,
        'vehicle': vehicle.toJson(),
        'owner': owner.toJson(),
        'driver': driver.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'otp': otp,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'status': status,
        'currency': currency.toJson(),
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory RentDetailsItem.empty() => RentDetailsItem(
      rent: Rent.empty(),
      createdAt: AppComponents.defaultUnsetDateTime,
      currency: Currency(),
      date: AppComponents.defaultUnsetDateTime,
      driver: Driver(),
      owner: Owner(),
      updatedAt: AppComponents.defaultUnsetDateTime,
      user: User(),
      vehicle: Vehicle.empty(),
      payment: Payment());
  static RentDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? RentDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : RentDetailsItem.empty();
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

class Rent {
  Facilities facilities;
  String id;
  String address;

  Rent({required this.facilities, this.id = '', this.address = ''});

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
        facilities:
            Facilities.fromJson(json['facilities'] as Map<String, dynamic>),
        id: json['_id'] as String,
        address: json['address'] as String,
      );

  Map<String, dynamic> toJson() => {
        'facilities': facilities.toJson(),
        '_id': id,
        'address': address,
      };

  factory Rent.empty() => Rent(facilities: Facilities());
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
        smoking: json['smoking'],
        luggage: json['luggage'],
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
  String maxPower;
  String maxSpeed;
  int capacity;
  String color;
  String fuelType;
  int mileage;
  String gearType;
  List<String> images;
  bool ac;

  Vehicle({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.model = '',
    this.year = '',
    this.maxPower = '',
    this.maxSpeed = '',
    this.capacity = 0,
    this.color = '',
    this.images = const [],
    this.fuelType = '',
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
    required this.category,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        category: Category.getAPIResponseObjectSafeValue(json['category']),
        model: APIHelper.getSafeStringValue(json['model']),
        year: APIHelper.getSafeStringValue(json['year']),
        maxPower: APIHelper.getSafeStringValue(json['max_power']),
        maxSpeed: APIHelper.getSafeStringValue(json['max_speed']),
        capacity: APIHelper.getSafeIntValue(json['capacity']),
        images: APIHelper.getSafeListValue(json['images'])
            .map((e) => APIHelper.getSafeStringValue(e))
            .toList(),
        color: APIHelper.getSafeStringValue(json['color']),
        fuelType: APIHelper.getSafeStringValue(json['fuel_type']),
        mileage: APIHelper.getSafeIntValue(json['mileage']),
        gearType: APIHelper.getSafeStringValue(json['gear_type']),
        ac: APIHelper.getSafeBoolValue(json['ac']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'category': category.toJson(),
        'model': model,
        'images': images,
        'year': year,
        'max_power': maxPower,
        'max_speed': maxSpeed,
        'capacity': capacity,
        'color': color,
        'fuel_type': fuelType,
        'mileage': mileage,
        'gear_type': gearType,
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

class User {
  String id;
  String uid;
  String name;
  String email;
  String image;

  User({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.email = '',
    this.image = '',
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
      };

  static User getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? User.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : User();
}

class Owner {
  String id;
  String uid;
  String name;
  String email;
  String image;

  Owner({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.email = '',
    this.image = '',
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'image': image,
      };

  static Owner getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Owner.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Owner();
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

class Currency {
  String id;
  String name;
  String code;
  String symbol;
  double rate;

  Currency({
    this.id = '',
    this.name = '',
    this.code = '',
    this.rate = 0,
    this.symbol = '',
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
        'rate': rate,
      };

  static Currency getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Currency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Currency();
}
