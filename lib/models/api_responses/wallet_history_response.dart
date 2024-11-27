import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class WalletTransactionHistoryResponse {
  bool error;
  String msg;
  PaginatedDataResponse<TransactionHistoryItems> data;

  WalletTransactionHistoryResponse(
      {this.error = false, this.msg = '', required this.data});

  factory WalletTransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return WalletTransactionHistoryResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            TransactionHistoryItems.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory WalletTransactionHistoryResponse.empty() =>
      WalletTransactionHistoryResponse(
        data: PaginatedDataResponse.empty(),
      );
  static WalletTransactionHistoryResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? WalletTransactionHistoryResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : WalletTransactionHistoryResponse.empty();
}

class TransactionHistoryItems {
  String id;
  String uid;
  String status;
  DateTime createdAt;
  double amount;
  String transactionId;
  String type;
  String method;

  TransactionHistoryItems({
    this.id = '',
    this.uid = '',
    this.status = '',
    required this.createdAt,
    this.amount = 0,
    this.type = '',
    this.method = '',
    this.transactionId = '',
  });

  factory TransactionHistoryItems.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryItems(
        id: APIHelper.getSafeStringValue(json['_id']),
        uid: APIHelper.getSafeStringValue(json['uid']),
        status: APIHelper.getSafeStringValue(json['status']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        amount: APIHelper.getSafeDoubleValue(json['amount']),
        transactionId: APIHelper.getSafeStringValue(json['transaction_id']),
        type: APIHelper.getSafeStringValue(json['type']),
        method: APIHelper.getSafeStringValue(json['method']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'uid': uid,
        'status': status,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'amount': amount,
        'transaction_id': transactionId,
        'type': type,
        'method': method,
      };

  factory TransactionHistoryItems.empty() =>
      TransactionHistoryItems(createdAt: AppComponents.defaultUnsetDateTime);
  static TransactionHistoryItems getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? TransactionHistoryItems.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : TransactionHistoryItems.empty();
}
