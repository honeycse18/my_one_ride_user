import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class MyRentListResponse {
  bool error;
  String msg;
  MyRentListData data;

  MyRentListResponse({this.error = false, this.msg = '', required this.data});

  factory MyRentListResponse.fromJson(Map<String, dynamic> json) {
    return MyRentListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: MyRentListData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory MyRentListResponse.empty() => MyRentListResponse(
        data: MyRentListData(),
      );
  static MyRentListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyRentListResponse.empty();
}

class MyRentListData {
  int page;
  int limit;
  int totalDocs;
  int totalPages;
  List<MyRentListDoc> docs;
  bool hasNextPage;
  bool hasPrevPage;

  MyRentListData({
    this.page = 0,
    this.limit = 0,
    this.totalDocs = 0,
    this.totalPages = 0,
    this.docs = const [],
    this.hasNextPage = false,
    this.hasPrevPage = false,
  });

  factory MyRentListData.fromJson(Map<String, dynamic> json) => MyRentListData(
        page: APIHelper.getSafeIntValue(json['page']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) => MyRentListDoc.fromJson(e as Map<String, dynamic>))
            .toList(),
        hasNextPage: APIHelper.getSafeBoolValue(json['hasNextPage']),
        hasPrevPage: APIHelper.getSafeBoolValue(json['hasPrevPage']),
      );

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'totalDocs': totalDocs,
        'totalPages': totalPages,
        'docs': docs.map((e) => e.toJson()).toList(),
        'hasNextPage': hasNextPage,
        'hasPrevPage': hasPrevPage,
      };

  static MyRentListData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListData.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyRentListData();
}

class MyRentListDoc {
  String id;
  MyRentListUser user;
  dynamic rent;
  MyRentListVehicle vehicle;
  MyRentListOwner owner;
  MyRentListDriver driver;
  DateTime date;
  String type;
  int rate;
  int quantity;
  int total;
  String paymentMethod;
  String status;
  bool paid;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  MyRentListDoc({
    this.id = '',
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
    this.paymentMethod = '',
    this.status = '',
    this.paid = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
  });

  factory MyRentListDoc.fromJson(Map<String, dynamic> json) => MyRentListDoc(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: MyRentListUser.getAPIResponseObjectSafeValue(json['user']),
        rent: json['rent'],
        vehicle:
            MyRentListVehicle.getAPIResponseObjectSafeValue(json['vehicle']),
        owner: MyRentListOwner.getAPIResponseObjectSafeValue(json['owner']),
        driver: MyRentListDriver.getAPIResponseObjectSafeValue(json['driver']),
        date: APIHelper.getSafeDateTimeValue(json['date']),
        type: APIHelper.getSafeStringValue(json['type']),
        rate: APIHelper.getSafeIntValue(json['rate']),
        quantity: APIHelper.getSafeIntValue(json['quantity']),
        total: APIHelper.getSafeIntValue(json['total']),
        paymentMethod: APIHelper.getSafeStringValue(json['payment_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        paid: APIHelper.getSafeBoolValue(json['paid']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
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
        'payment_method': paymentMethod,
        'status': status,
        'paid': paid,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
      };

  factory MyRentListDoc.empty() => MyRentListDoc(
      user: MyRentListUser(),
      vehicle: MyRentListVehicle.empty(),
      owner: MyRentListOwner(),
      driver: MyRentListDriver(),
      date: AppComponents.defaultUnsetDateTime,
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static MyRentListDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListDoc.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyRentListDoc.empty();
}

class MyRentListVehicle {
  String id;
  String uid;
  String name;
  MyRentListCategory category;
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

  MyRentListVehicle({
    this.id = '',
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
    this.mileage = 0,
    this.gearType = '',
    this.ac = false,
    this.vehicleNumber = '',
  });

  factory MyRentListVehicle.fromJson(Map<String, dynamic> json) =>
      MyRentListVehicle(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        category:
            MyRentListCategory.getAPIResponseObjectSafeValue(json['category']),
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

  factory MyRentListVehicle.empty() => MyRentListVehicle(
        category: MyRentListCategory(),
      );
  static MyRentListVehicle getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListVehicle.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyRentListVehicle.empty();
}

class MyRentListCategory {
  String id;
  String uid;
  String name;
  String image;

  MyRentListCategory(
      {this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory MyRentListCategory.fromJson(Map<String, dynamic> json) =>
      MyRentListCategory(
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

  static MyRentListCategory getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListCategory.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyRentListCategory();
}

class MyRentListDriver {
  String id;
  String uid;
  String name;

  MyRentListDriver({this.id = '', this.uid = '', this.name = ''});

  factory MyRentListDriver.fromJson(Map<String, dynamic> json) =>
      MyRentListDriver(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static MyRentListDriver getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListDriver.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyRentListDriver();
}

class MyRentListOwner {
  String id;
  String uid;
  String name;

  MyRentListOwner({this.id = '', this.uid = '', this.name = ''});

  factory MyRentListOwner.fromJson(Map<String, dynamic> json) =>
      MyRentListOwner(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
      };

  static MyRentListOwner getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListOwner.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : MyRentListOwner();
}

class MyRentListUser {
  String id;
  String uid;
  String name;
  String image;

  MyRentListUser(
      {this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory MyRentListUser.fromJson(Map<String, dynamic> json) => MyRentListUser(
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

  static MyRentListUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? MyRentListUser.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : MyRentListUser();
}
