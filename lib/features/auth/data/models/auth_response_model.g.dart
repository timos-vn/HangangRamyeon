// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      shop: (json['shop'] as List<dynamic>).map((e) => e as String).toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      accessToken: json['token'] as String,
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      userName: json['userName'] as String,
      fullName: json['fullName'] as String?,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      deviceToken: json['deviceToken'] as String?,
    );

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
    );
