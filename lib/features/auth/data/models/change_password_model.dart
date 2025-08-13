import 'package:json_annotation/json_annotation.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;
  final String UserId;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.UserId,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}

@JsonSerializable()
class ChangePasswordResponse {
  final bool succeeded;
  final List<String> errors;
  final String? data;

  ChangePasswordResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}
