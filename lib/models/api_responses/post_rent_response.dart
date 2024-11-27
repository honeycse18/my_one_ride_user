import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class PostRentResponse {
  bool error;
  String msg;
  PostRentDetailsItem data;

  PostRentResponse({this.error = false, this.msg = '', required this.data});

  factory PostRentResponse.fromJson(Map<String, dynamic> json) {
    return PostRentResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PostRentDetailsItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory PostRentResponse.empty() =>
      PostRentResponse(data: PostRentDetailsItem.empty());
  static PostRentResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostRentResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostRentResponse.empty();
}

class PostRentDetailsItem {
  User user;
  String rent;
  Vehicle vehicle;
  Owner owner;
  Driver driver;
  DateTime date;
  String type;
  double rate;
  int quantity;
  double total;
  String status;
  String otp;
  Currency currency;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  Payment payment;

  PostRentDetailsItem({
    required this.user,
    this.rent = '',
    required this.vehicle,
    required this.owner,
    required this.driver,
    required this.date,
    this.type = '',
    this.rate = 0,
    this.quantity = 0,
    this.total = 0,
    this.status = '',
    this.otp = '',
    required this.payment,
    required this.currency,
    this.id = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostRentDetailsItem.fromJson(Map<String, dynamic> json) =>
      PostRentDetailsItem(
        user: User.getAPIResponseObjectSafeValue(json['user']),
        rent: APIHelper.getSafeStringValue(json['rent']),
        vehicle: Vehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        owner: Owner.getAPIResponseObjectSafeValue(json['owner']),
        driver: Driver.getAPIResponseObjectSafeValue(json['driver']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        total: APIHelper.getSafeDoubleValue(json['total']),
        payment: Payment.getAPIResponseObjectSafeValue(json['payment']),
        status: APIHelper.getSafeStringValue(json['status']),
        currency: Currency.fromJson(json['currency']),
        id: APIHelper.getSafeStringValue(json['_id']),
        otp: APIHelper.getSafeStringValue(json['otp']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'rent': rent,
        'vehicle': vehicle.toJson(),
        'owner': owner.toJson(),
        'driver': driver.toJson(),
        'date': APIHelper.toServerDateTimeFormattedStringFromDateTime(date),
        'type': type,
        'rate': rate,
        'quantity': quantity,
        'total': total,
        'status': status,
        'otp': otp,
        'payment': payment.toJson(),
        'currency': currency.toJson(),
        '_id': id,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory PostRentDetailsItem.empty() => PostRentDetailsItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        currency: Currency(),
        date: AppComponents.defaultUnsetDateTime,
        driver: Driver(),
        owner: Owner(),
        payment: Payment(),
        updatedAt: AppComponents.defaultUnsetDateTime,
        user: User(),
        vehicle: Vehicle.empty(),
      );
  static PostRentDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? PostRentDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : PostRentDetailsItem.empty();
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

class Payment {
  String method;
  String status;
  String transactionId;
  double amount;

  Payment({
    this.method = '',
    this.status = '',
    this.amount = 0,
    this.transactionId = '',
  });

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
