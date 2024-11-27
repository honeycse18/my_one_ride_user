import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class AllCategoriesResponse {
  bool error;
  String msg;
  AllCategoriesData data;

  AllCategoriesResponse(
      {this.error = false, this.msg = '', required this.data});

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) {
    return AllCategoriesResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: AllCategoriesData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory AllCategoriesResponse.empty() => AllCategoriesResponse(
        data: AllCategoriesData(),
      );
  static AllCategoriesResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesResponse.empty();
}

class AllCategoriesData {
  int page;
  int limit;
  int totalDocs;
  int totalPages;
  List<AllCategoriesDoc> docs;
  bool hasNextPage;
  bool hasPrevPage;

  AllCategoriesData({
    this.page = 0,
    this.limit = 0,
    this.totalDocs = 0,
    this.totalPages = 0,
    this.docs = const [],
    this.hasNextPage = false,
    this.hasPrevPage = false,
  });

  factory AllCategoriesData.fromJson(Map<String, dynamic> json) =>
      AllCategoriesData(
        page: APIHelper.getSafeIntValue(json['page']),
        limit: APIHelper.getSafeIntValue(json['limit']),
        totalDocs: APIHelper.getSafeIntValue(json['totalDocs']),
        totalPages: APIHelper.getSafeIntValue(json['totalPages']),
        docs: APIHelper.getSafeListValue(json['docs'])
            .map((e) => AllCategoriesDoc.fromJson(e))
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

  static AllCategoriesData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesData();
}

class AllCategoriesDoc {
  String id;
  String uid;
  String name;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String image;
  int baseFare;
  int minFare;
  int perKm;
  int perMin;

  AllCategoriesDoc({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.active = false,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    this.image = '',
    this.baseFare = 0,
    this.minFare = 0,
    this.perKm = 0,
    this.perMin = 0,
  });

  factory AllCategoriesDoc.fromJson(Map<String, dynamic> json) =>
      AllCategoriesDoc(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        active: APIHelper.getSafeBoolValue(json['active']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
        image: APIHelper.getSafeStringValue(json['image']),
        baseFare: APIHelper.getSafeIntValue(json['base_fare']),
        minFare: APIHelper.getSafeIntValue(json['min_fare']),
        perKm: APIHelper.getSafeIntValue(json['per_km']),
        perMin: APIHelper.getSafeIntValue(json['per_min']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'active': active,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
        '__v': v,
        'image': image,
        'base_fare': baseFare,
        'min_fare': minFare,
        'per_km': perKm,
        'per_min': perMin,
      };

  factory AllCategoriesDoc.empty() => AllCategoriesDoc(
      createdAt: AppComponents.defaultUnsetDateTime,
      updatedAt: AppComponents.defaultUnsetDateTime);
  static AllCategoriesDoc getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? AllCategoriesDoc.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : AllCategoriesDoc.empty();
}
