import 'package:json_annotation/json_annotation.dart';

part 'user_infor_qrcode.g.dart';

@JsonSerializable()
class UserInforQRCode {
  final String userName;
  final String userId;

  UserInforQRCode({
    required this.userName,
    required this.userId,
  });

  factory UserInforQRCode.fromJson(Map<String, dynamic> json) =>
      _$UserInforQRCodeFromJson(json);

  Map<String, dynamic> toJson() => _$UserInforQRCodeToJson(this);
}
