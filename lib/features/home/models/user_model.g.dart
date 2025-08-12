// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      succeeded: json['succeeded'] as bool,
      errors: json['errors'] as List<dynamic>,
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      birthDay: json['birthDay'] as String?,
      point: (json['point'] as num).toInt(),
      pointName: json['pointName'] as String?,
      pointId: json['pointId'] as String?,
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => Shop.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => UserRole.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'birthDay': instance.birthDay,
      'point': instance.point,
      'pointName': instance.pointName,
      'pointId': instance.pointId,
      'shops': instance.shops,
      'roles': instance.roles,
    };

UserRole _$UserRoleFromJson(Map<String, dynamic> json) => UserRole(
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
    );

Map<String, dynamic> _$UserRoleToJson(UserRole instance) => <String, dynamic>{
      'roleId': instance.roleId,
      'roleName': instance.roleName,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
    };
