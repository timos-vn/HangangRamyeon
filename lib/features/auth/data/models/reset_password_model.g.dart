// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordRequest(
      UserId: json['UserId'] as String,
      NewPassword: json['NewPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordRequestToJson(
        ResetPasswordRequest instance) =>
    <String, dynamic>{
      'UserId': instance.UserId,
      'NewPassword': instance.NewPassword,
    };

ResetPasswordResponse _$ResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$ResetPasswordResponseToJson(
        ResetPasswordResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };
