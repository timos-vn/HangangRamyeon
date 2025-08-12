import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponseModel {
  final bool succeeded;
  final List<String> errors;
  final AuthData data;

  AuthResponseModel({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class AuthData {
  final User user;
  final List<String> shop;
  final List<Role> roles;

  @JsonKey(name: 'token')
  final String accessToken;

  AuthData({
    required this.user,
    required this.shop,
    required this.roles,
    required this.accessToken,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}

@JsonSerializable(createToJson: false)
class User {
  final String id;
  final String userName;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? deviceToken;

  User({
    required this.id,
    required this.userName,
    this.fullName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}



@JsonSerializable(createToJson: false)
class Role {
  final String roleId;
  final String roleName;

  Role({
    required this.roleId,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
