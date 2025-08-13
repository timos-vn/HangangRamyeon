// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateRequest _$UserUpdateRequestFromJson(Map<String, dynamic> json) =>
    UserUpdateRequest(
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      FirstName: json['FirstName'] as String,
      LastName: json['LastName'] as String,
      FullName: json['FullName'] as String,
      Gender: json['Gender'] as String,
      BirthDay: json['BirthDay'] as String,
      avatarUrl: json['avatarUrl'] as String,
      deviceToken: json['deviceToken'] as String,
      shopId: json['shopId'] as String,
    );

Map<String, dynamic> _$UserUpdateRequestToJson(UserUpdateRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'FullName': instance.FullName,
      'Gender': instance.Gender,
      'BirthDay': instance.BirthDay,
      'avatarUrl': instance.avatarUrl,
      'deviceToken': instance.deviceToken,
      'shopId': instance.shopId,
    };

UserUpdateResponse _$UserUpdateResponseFromJson(Map<String, dynamic> json) =>
    UserUpdateResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$UserUpdateResponseToJson(UserUpdateResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };
