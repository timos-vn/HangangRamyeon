import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoResponse {
  final bool succeeded;
  final List<String> errors;
  final UserInfoData? data;

  UserInfoResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}

@JsonSerializable()
class UserInfoData {
  final String userId;
  final String userName;
  final String? phoneNumber;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? gender;
  final String? birthDay;
  final String? avatarUrl;
  final String? shopId;

  UserInfoData({
    required this.userId,
    required this.userName,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.gender,
    this.birthDay,
    this.avatarUrl,
    this.shopId,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}
