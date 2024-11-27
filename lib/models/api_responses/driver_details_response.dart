import 'package:one_ride_user/utils/helpers/api_helper.dart';

class DriverDetailsResponse {
  bool error;
  String msg;
  DriverDetailsData data;

  DriverDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory DriverDetailsResponse.fromJson(Map<String, dynamic> json) {
    return DriverDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: DriverDetailsData.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory DriverDetailsResponse.empty() => DriverDetailsResponse(
        data: DriverDetailsData.empty(),
      );
  static DriverDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverDetailsResponse.empty();
}

class DriverDetailsData {
  String id;
  String uid;
  String name;
  String phone;
  String email;
  String image;
  String address;
  DriverDetailsLocation location;
  String about;
  String experience;
  double rate;
  DriverDetailsHires hires;

  DriverDetailsData({
    this.id = '',
    this.uid = '',
    this.name = '',
    this.phone = '',
    this.email = '',
    this.image = '',
    this.address = '',
    required this.location,
    this.about = '',
    this.experience = '',
    this.rate = 0,
    required this.hires,
  });

  factory DriverDetailsData.fromJson(Map<String, dynamic> json) =>
      DriverDetailsData(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        name: APIHelper.getSafeStringValue(json['name']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        email: APIHelper.getSafeStringValue(json['email']),
        image: APIHelper.getSafeStringValue(json['image']),
        address: APIHelper.getSafeStringValue(json['address']),
        location: DriverDetailsLocation.getAPIResponseObjectSafeValue(
            json['location']),
        about: APIHelper.getSafeStringValue(json['about']),
        experience: APIHelper.getSafeStringValue(json['experience']),
        rate: APIHelper.getSafeDoubleValue(json['rate']),
        hires: DriverDetailsHires.getAPIResponseObjectSafeValue(json['hires']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'name': name,
        'phone': phone,
        'email': email,
        'image': image,
        'address': address,
        'location': location.toJson(),
        'about': about,
        'experience': experience,
        'rate': rate,
        'hires': hires.toJson(),
      };

  factory DriverDetailsData.empty() => DriverDetailsData(
      location: DriverDetailsLocation(), hires: DriverDetailsHires());
  static DriverDetailsData getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverDetailsData.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverDetailsData.empty();
}

class DriverDetailsHires {
  String id;
  int total;
  double rating;

  DriverDetailsHires({this.id = '', this.total = 0, this.rating = 0});

  factory DriverDetailsHires.fromJson(Map<String, dynamic> json) =>
      DriverDetailsHires(
        id: APIHelper.getSafeStringValue(json['_id']),
        total: APIHelper.getSafeIntValue(json['total']),
        rating: APIHelper.getSafeDoubleValue(json['rating']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'total': total,
        'rating': rating,
      };

  static DriverDetailsHires getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverDetailsHires.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverDetailsHires();
}

class DriverDetailsLocation {
  double lat;
  double lng;

  DriverDetailsLocation({this.lat = 0, this.lng = 0});

  factory DriverDetailsLocation.fromJson(Map<String, dynamic> json) =>
      DriverDetailsLocation(
        lat: APIHelper.getSafeDoubleValue(json['lat']),
        lng: APIHelper.getSafeDoubleValue(json['lng']),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  static DriverDetailsLocation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? DriverDetailsLocation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : DriverDetailsLocation();
}
