// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingResponse _$SettingResponseFromJson(Map<String, dynamic> json) =>
    SettingResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : SettingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SettingResponseToJson(SettingResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

SettingData _$SettingDataFromJson(Map<String, dynamic> json) => SettingData(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: (json['data'] as List<dynamic>)
          .map((e) => SettingItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettingDataToJson(SettingData instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

SettingItem _$SettingItemFromJson(Map<String, dynamic> json) => SettingItem(
      key: json['key'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$SettingItemToJson(SettingItem instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
