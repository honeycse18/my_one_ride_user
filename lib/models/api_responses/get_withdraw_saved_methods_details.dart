import 'package:flutter/material.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class GetWithdrawSavedMethodsDetailsResponse {
  bool error;
  String msg;
  WithdrawMethodsDetailsItem data;

  GetWithdrawSavedMethodsDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory GetWithdrawSavedMethodsDetailsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetWithdrawSavedMethodsDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: WithdrawMethodsDetailsItem.getAPIResponseObjectSafeValue(
          json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory GetWithdrawSavedMethodsDetailsResponse.empty() =>
      GetWithdrawSavedMethodsDetailsResponse(
        data: WithdrawMethodsDetailsItem.empty(),
      );
  static GetWithdrawSavedMethodsDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetWithdrawSavedMethodsDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetWithdrawSavedMethodsDetailsResponse.empty();
}

class WithdrawMethodsDetailsItem {
  String id;
  String user;
  String type;
  Details details;
  DateTime createdAt;
  DateTime updatedAt;

  WithdrawMethodsDetailsItem({
    this.id = '',
    this.user = '',
    this.type = '',
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WithdrawMethodsDetailsItem.fromJson(Map<String, dynamic> json) =>
      WithdrawMethodsDetailsItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: APIHelper.getSafeStringValue(json['user']),
        type: APIHelper.getSafeStringValue(json['type']),
        details: Details.getAPIResponseObjectSafeValue(json['details']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user,
        'type': type,
        'details': details.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory WithdrawMethodsDetailsItem.empty() => WithdrawMethodsDetailsItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      details: Details(),
      updatedAt: AppComponents.defaultUnsetDateTime);
  static WithdrawMethodsDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethodsDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethodsDetailsItem.empty();
}

class Details {
  String payAccountName;
  String payAccountEmail;
  String cardName;
  String cardNumber;
  String cardExpiry;
  String cardCvvNumber;
  String postalCode;
  String bankAccountName;
  String bankName;
  String branchCode;
  String accountNumber;

  Details({
    this.payAccountName = '',
    this.payAccountEmail = '',
    this.cardName = '',
    this.cardNumber = '',
    this.cardExpiry = '',
    this.cardCvvNumber = '',
    this.postalCode = '',
    this.bankAccountName = '',
    this.bankName = '',
    this.branchCode = '',
    this.accountNumber = '',
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        payAccountName: APIHelper.getSafeStringValue(json['account_name']),
        payAccountEmail: APIHelper.getSafeStringValue(json['account_email']),
        cardName: APIHelper.getSafeStringValue(json['card_name']),
        cardNumber: APIHelper.getSafeStringValue(json['card_number']),
        cardExpiry: APIHelper.getSafeStringValue(json['card_expire_date']),
        cardCvvNumber: APIHelper.getSafeStringValue(json['cvv_number']),
        postalCode: APIHelper.getSafeStringValue(json['postal_code']),
        bankAccountName:
            APIHelper.getSafeStringValue(json['bank_account_name']),
        bankName: APIHelper.getSafeStringValue(json['bank_name']),
        branchCode: APIHelper.getSafeStringValue(json['branch_code']),
        accountNumber: APIHelper.getSafeStringValue(json['account_number']),
      );

  Map<String, dynamic> toJson() => {
        'account_name': payAccountName,
        'account_email': payAccountEmail,
        'card_name': cardName,
        'card_number': cardNumber,
        'card_expire_date': cardExpiry,
        'cvv_number': cardCvvNumber,
        'postal_code': postalCode,
        'bank_account_name': bankAccountName,
        'bank_name': bankName,
        'branch_code': branchCode,
        'account_number': accountNumber,
      };

  static Details getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? Details.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : Details();
}
