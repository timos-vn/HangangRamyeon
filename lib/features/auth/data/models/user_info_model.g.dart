// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : UserInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      birthDay: json['birthDay'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      shopId: json['shopId'] as String?,
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'birthDay': instance.birthDay,
      'avatarUrl': instance.avatarUrl,
      'shopId': instance.shopId,
    };
