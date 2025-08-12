import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final bool succeeded;
  final List<dynamic> errors;
  final UserData data;

  UserModel({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserData {
  final String userId;
  final String userName;
  final String email;
  final String? phoneNumber;
  final String? fullName;
  final String? birthDay;
  final int point;
  final String? pointName;
  final String? pointId;
  final List<Shop>? shops;
  final List<UserRole> roles;

  UserData({
    required this.userId,
    required this.userName,
    required this.email,
    this.phoneNumber,
    this.fullName,
    this.birthDay,
    required this.point,
    this.pointName,
    this.pointId,
    required this.shops,
    required this.roles,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class UserRole {
  final String roleId;
  final String roleName;

  UserRole({
    required this.roleId,
    required this.roleName,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
}

@JsonSerializable()
class Shop {
  final String? shopId;
  final String? shopName;

  Shop({
    this.shopId,
    this.shopName,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
}