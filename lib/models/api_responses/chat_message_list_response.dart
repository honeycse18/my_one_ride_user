import 'package:one_ride_user/models/api_responses/core_api_responses/paginated_data_response.dart';
import 'package:one_ride_user/utils/constants/app_components.dart';
import 'package:one_ride_user/utils/helpers/api_helper.dart';

class ChatMessageListResponse {
  bool error;
  String msg;
  PaginatedDataResponse<ChatMessageListItem> data;

  ChatMessageListResponse(
      {this.error = false, this.msg = '', required this.data});

  factory ChatMessageListResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessageListResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: PaginatedDataResponse.getAPIResponseObjectSafeValue(
        json['data'],
        docFromJson: (data) =>
            ChatMessageListItem.getAPIResponseObjectSafeValue(data),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.toJson((item) => item.toJson()),
      };

  factory ChatMessageListResponse.empty() => ChatMessageListResponse(
        data: PaginatedDataResponse.empty(),
      );
  static ChatMessageListResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessageListResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatMessageListResponse.empty();
}

class ChatMessageListItem {
  String id;
  From from;
  To to;
  String message;
  bool read;
  DateTime createdAt;
  DateTime updatedAt;

  ChatMessageListItem({
    this.id = '',
    required this.from,
    required this.to,
    this.message = '',
    this.read = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatMessageListItem.fromJson(Map<String, dynamic> json) =>
      ChatMessageListItem(
        id: APIHelper.getSafeStringValue(json['_id']),
        from: From.getAPIResponseObjectSafeValue(json['from']),
        to: To.getAPIResponseObjectSafeValue(json['to']),
        message: APIHelper.getSafeStringValue(json['message']),
        read: APIHelper.getSafeBoolValue(json['read']),
        createdAt: APIHelper.getSafeDateTimeValue(json['createdAt']),
        updatedAt: APIHelper.getSafeDateTimeValue(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'from': from.toJson(),
        'to': to.toJson(),
        'message': message,
        'read': read,
        'createdAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(createdAt),
        'updatedAt':
            APIHelper.toServerDateTimeFormattedStringFromDateTime(updatedAt),
      };

  factory ChatMessageListItem.empty() => ChatMessageListItem(
        createdAt: AppComponents.defaultUnsetDateTime,
        from: From(),
        to: To(),
        updatedAt: AppComponents.defaultUnsetDateTime,
      );
  static ChatMessageListItem getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? ChatMessageListItem.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : ChatMessageListItem.empty();
}

class From {
  String id;
  String uid;
  String name;
  String image;

  From({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory From.fromJson(Map<String, dynamic> json) => From(
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

  static From getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? From.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : From();
}

class To {
  String id;
  String uid;
  String name;
  String image;

  To({this.id = '', this.uid = '', this.name = '', this.image = ''});

  factory To.fromJson(Map<String, dynamic> json) => To(
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

  static To getAPIResponseObjectSafeValue(dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? To.fromJson(unsafeResponseValue as Map<String, dynamic>)
          : To();
}
