

import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class WithdrawHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<WalletWithdrawMethodItem> data;

  WithdrawHistoryResponse({this.error=false, this.msg='', required this.data});

  factory WithdrawHistoryResponse.fromJson(Map<String, dynamic> json) {
    return WithdrawHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error'] ),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            WalletWithdrawMethodItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

      
          factory WithdrawHistoryResponse.empty() => WithdrawHistoryResponse(
              data: PaginatedDataResponse.empty(),
      );
          static WithdrawHistoryResponse getAPIResponseObjectSafeValue(
              dynamic unsafeResponseValue) =>
          APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
              ? WithdrawHistoryResponse.fromJson(
                  unsafeResponseValue as Map<String, dynamic>)
              : WithdrawHistoryResponse.empty();
      
}
class Currency {
  String id;
  String name;
  String code;
  String symbol;
  int rate;

  Currency(
      {this.id = '',
      this.name = '',
      this.code = '',
      this.symbol = '',
      this.rate = 0});

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
        rate: APIHelper.getSafeIntValue(json['rate']),
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


class WalletWithdrawMethodItem {
  String id;
  WithdrawUser user;
  double amount;
  WithdrawMethod withdrawMethod;
  String status;
  Currency currency;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  WalletWithdrawMethodItem({
    this.id = '',
    required this.user,
    this.amount = 0,
    this.status = '',
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.v = 0,
    required this.withdrawMethod,
  });

  factory WalletWithdrawMethodItem.fromJson(Map<String, dynamic> json) =>
      WalletWithdrawMethodItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        user: WithdrawUser.getAPIResponseObjectSafeValue(json['user']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        withdrawMethod: WithdrawMethod.getAPIResponseObjectSafeValue(
            json['withdraw_method']),
        status: APIHelper.getSafeStringValue(json['status']),
        currency: Currency.getAPIResponseObjectSafeValue(json['currency']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
        v: APIHelper.getSafeIntValue(json['__v']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'amount': amount,
        'withdraw_method': withdrawMethod.toJson(),
        'status': status,
        'currency': currency.toJson(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };

  factory WalletWithdrawMethodItem.empty() => WalletWithdrawMethodItem(
      createdAt: AppComponents.defaultUnsetDateTime,
      currency: Currency(),
      updatedAt: AppComponents.defaultUnsetDateTime,
      user: WithdrawUser(),
      withdrawMethod: WithdrawMethod());
  static WalletWithdrawMethodItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletWithdrawMethodItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletWithdrawMethodItem.empty();
}

class WithdrawUser {
  String id;
  String name;
  String email;

  WithdrawUser({this.id = '', this.name = '', this.email = ''});

  factory WithdrawUser.fromJson(Map<String, dynamic> json) => WithdrawUser(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
      };

  static WithdrawUser getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawUser.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WithdrawUser();
}

class WithdrawMethod {
  String id;
  String type;

  WithdrawMethod({this.id = '', this.type = ''});

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) {
    return WithdrawMethod(
      id: APIHelper.getSafeStringValue(json['_id']),
      type: APIHelper.getSafeStringValue(json['type']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
      };

  static WithdrawMethod getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WithdrawMethod.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WithdrawMethod();
}
