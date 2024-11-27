import 'package:one_ride_user/utils/helpers/api_helper.dart';

class LanguageTranslationsResponse {
  bool error;
  String msg;
  List<LanguageTranslation> data;

  LanguageTranslationsResponse(
      {this.error = false, this.msg = '', this.data = const []});

  factory LanguageTranslationsResponse.fromJson(Map<String, dynamic> json) {
    return LanguageTranslationsResponse(
      error: APIHelper.getSafeBoolValue(json['error']),
      msg: APIHelper.getSafeStringValue(json['msg']),
      data: APIHelper.getSafeListValue(json['data'])
          .map((e) => LanguageTranslation.getAPIResponseObjectSafeValue(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'error': error,
        'msg': msg,
        'data': data.map((e) => e.toJson()).toList(),
      };
  static LanguageTranslationsResponse getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LanguageTranslationsResponse.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LanguageTranslationsResponse();
}

class LanguageTranslation {
  String id;
  String name;
  String code;
  String flag;
  bool isRTL;
  bool isDefault;
  Map<String, String> translation;

  LanguageTranslation({
    this.id = '',
    this.name = '',
    this.code = '',
    this.flag = '',
    this.isDefault = false,
    this.isRTL = false,
    this.translation = const {},
  });

  factory LanguageTranslation.fromJson(Map<String, dynamic> json) =>
      LanguageTranslation(
        id: APIHelper.getSafeStringValue(json['_id']),
        name: APIHelper.getSafeStringValue(json['name']),
        code: APIHelper.getSafeStringValue(json['code']),
        flag: APIHelper.getSafeStringValue(json['flag']),
        isDefault: APIHelper.getSafeBoolValue(json['default']),
        isRTL: APIHelper.getSafeBoolValue(json['rtl']),
        // translation: Translation.fromJson(json['translation'] as Map<String, dynamic>),
        translation: (json['translations'] is Map<String, dynamic>
            ? getProperTranslationMap(json['translations'])
            : {}),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'flag': flag,
        'rtl': isRTL,
        'default': isDefault,
        'translations': translation,
      };

  static Map<String, String> getProperTranslationMap(
      Map<String, dynamic> translationMap) {
    Map<String, String> properTranslationMap = <String, String>{};
    translationMap.forEach((key, value) {
      if (value is String) {
        properTranslationMap[key] = value;
      }
    });
    return properTranslationMap;
  }

  static LanguageTranslation getAPIResponseObjectSafeValue(
          dynamic unsafeResponseValue) =>
      APIHelper.isAPIResponseObjectSafe(unsafeResponseValue)
          ? LanguageTranslation.fromJson(
              unsafeResponseValue as Map<String, dynamic>)
          : LanguageTranslation();
}
