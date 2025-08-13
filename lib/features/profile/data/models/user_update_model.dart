import 'package:json_annotation/json_annotation.dart';

part 'user_update_model.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  final String phoneNumber;
  final String email;
  final String FirstName;
  final String LastName;
  final String FullName;
  final String Gender;
  final String BirthDay;
  final String avatarUrl;
  final String deviceToken;
  final String shopId;

  UserUpdateRequest({
    required this.phoneNumber,
    required this.email,
    required this.FirstName,
    required this.LastName,
    required this.FullName,
    required this.Gender,
    required this.BirthDay,
    required this.avatarUrl,
    required this.deviceToken,
    required this.shopId,
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}

@JsonSerializable()
class UserUpdateResponse {
  final bool succeeded;
  final List<String> errors;
  final String? data;

  UserUpdateResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory UserUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateResponseToJson(this);
}
