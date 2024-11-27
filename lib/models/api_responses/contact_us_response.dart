import 'dart:convert';

import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class ContactUsResponse {
  bool error;
  String msg;
  ContactUsDataItem data;

  ContactUsResponse({this.error = false, this.msg = '', required this.data});

  factory ContactUsResponse.fromJson(Map<String, dynamic> json) {
    return ContactUsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: ContactUsDataItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory ContactUsResponse.empty() => ContactUsResponse(
        data: ContactUsDataItem.empty(),
      );
  static ContactUsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ContactUsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ContactUsResponse.empty();
}

class ContactUsDataItem {
  String id;
  String title;
  String slug;
  String contentType;
  Content content;
  DateTime createdAt;
  DateTime updatedAt;

  ContactUsDataItem({
    this.id = '',
    this.title = '',
    this.slug = '',
    required this.content,
    this.contentType = '',
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactUsDataItem.fromJson(Map<String, dynamic> json) =>
      ContactUsDataItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        title: APIHelper.getSafeStringValue(json['title']),
        slug: APIHelper.getSafeStringValue(json['slug']),
        contentType: APIHelper.getSafeStringValue(json['content_type']),
        content:
            Content.getAPIResponseObjectSafeValue(jsonDecode(json['content'])),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'slug': slug,
        'content_type': contentType,
        'content': content,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory ContactUsDataItem.empty() => ContactUsDataItem(
        content: Content.empty(),
        createdAt: AppComponents.defaultUnsetDateTime,
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static ContactUsDataItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ContactUsDataItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ContactUsDataItem.empty();
}

class Content {
  ContactUs contactUs;
  String map;

  Content({required this.contactUs, this.map = ''});

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contactUs: ContactUs.getAPIResponseObjectSafeValue(json['contact_us']),
        map: APIHelper.getSafeStringValue(json['map']),
      );

  Map<String, dynamic> toJson() => {
        'contact_us': contactUs.toJson(),
        'map': map,
      };

  factory Content.empty() => Content(contactUs: ContactUs());
  static Content getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Content.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Content.empty();
}

class ContactUs {
  String heading;
  String email;
  String phone;
  List<OfficeAddress> officeAddresses;

  ContactUs(
      {this.heading = '',
      this.email = '',
      this.phone = '',
      this.officeAddresses = const []});

  factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
        heading: APIHelper.getSafeStringValue(json['heading']),
        email: APIHelper.getSafeStringValue(json['email']),
        phone: APIHelper.getSafeStringValue(json['phone']),
        officeAddresses: APIHelper.getSafeListValue(json['office_addresses'])
            .map((e) => OfficeAddress.getAPIResponseObjectSafeValue(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'heading': heading,
        'email': email,
        'phone': phone,
        'office_addresses': officeAddresses.map((e) => e.toJson()).toList(),
      };

  static ContactUs getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ContactUs.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : ContactUs();
}

class OfficeAddress {
  String address;

  OfficeAddress({this.address = ''});

  factory OfficeAddress.fromJson(Map<String, dynamic> json) => OfficeAddress(
        address: APIHelper.getSafeStringValue(json['address']),
      );

  Map<String, dynamic> toJson() => {
        'address': address,
      };

  static OfficeAddress getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? OfficeAddress.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : OfficeAddress();
}
