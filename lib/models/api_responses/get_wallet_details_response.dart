import 'package:one_ride_user/utils/helpers/api_helper.dart';

class GetWalletDetailsResponse {
  bool error;
  String msg;
  WalletDetailsItem data;

  GetWalletDetailsResponse(
      {this.error = false, this.msg = '', required this.data});

  factory GetWalletDetailsResponse.fromJson(Map<String, dynamic> json) {
    return GetWalletDetailsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: WalletDetailsItem.getAPIResponseObjectSafeValue(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson(),
      };

  factory GetWalletDetailsResponse.empty() => GetWalletDetailsResponse(
        data: WalletDetailsItem.empty(),
      );
  static GetWalletDetailsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? GetWalletDetailsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : GetWalletDetailsResponse.empty();
}

class WalletDetailsItem {
  String id;
  String name;
  String email;
  WalletCurrency currency;
  double balance;

  WalletDetailsItem(
      {this.id = '',
      this.name = '',
      this.email = '',
      required this.currency,
      this.balance = 0});

  factory WalletDetailsItem.fromJson(Map<String, dynamic> json) =>
      WalletDetailsItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        email: APIHelper.getSafeStringValue(json['email']),
        currency:
            WalletCurrency.getAPIResponseObjectSafeValue(json['currency']),
        balance: APIHelper.getSafeDoubleValue(json['balance']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'currency': currency.toJson(),
        'balance': balance,
      };

  factory WalletDetailsItem.empty() =>
      WalletDetailsItem(currency: WalletCurrency());
  static WalletDetailsItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletDetailsItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletDetailsItem.empty();
}

class WalletCurrency {
  String id;
  String name;
  String code;
  String symbol;

  WalletCurrency(
      {this.id = '', this.name = '', this.code = '', this.symbol = ''});

  factory WalletCurrency.fromJson(Map<String, dynamic> json) => WalletCurrency(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        symbol: APIHelper.getSafeStringValue(json['symbol']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'symbol': symbol,
      };

  static WalletCurrency getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletCurrency.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : WalletCurrency();
}
