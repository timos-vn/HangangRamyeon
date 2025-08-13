// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      UserId: json['UserId'] as String,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'UserId': instance.UserId,
    };

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };
