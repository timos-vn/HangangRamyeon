import 'package:json_annotation/json_annotation.dart';

part 'reset_password_model.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  final String UserId;
  final String NewPassword;

  ResetPasswordRequest({
    required this.UserId,
    required this.NewPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordResponse {
  final bool succeeded;
  final List<String> errors;
  final String? data;

  ResetPasswordResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
