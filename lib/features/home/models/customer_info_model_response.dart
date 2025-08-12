import 'package:json_annotation/json_annotation.dart';

part 'customer_info_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerInfoModelResponse {
  final bool succeeded;
  final List<String> errors;
  final CustomerInfoData data;

  CustomerInfoModelResponse({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory CustomerInfoModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerInfoModelResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomerInfoData {
  final int total;
  final List<CustomerItem> items;

  CustomerInfoData({
    required this.total,
    required this.items,
  });

  factory CustomerInfoData.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerInfoDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CustomerItem {
  final String? code;
  final String? name;
  final String? phoneNumber;
  final String? address;
  final String? email;
  final DateTime? dateOfBirth;
  final String? gender;
  final int? point;
  final int? pointUsed;
  final String? settingPointId;
  final SettingPoint settingPoint;
  final dynamic lastOrder;
  final bool? lastOrderStatus;
  final String? userId;
  final String? id;
  final List<dynamic> domainEvents;

  CustomerItem({
    required this.code,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.email,
    this.dateOfBirth,
    this.gender,
    required this.point,
    required this.pointUsed,
    required this.settingPointId,
    required this.settingPoint,
    this.lastOrder,
    required this.lastOrderStatus,
    required this.userId,
    required this.id,
    required this.domainEvents,
  });

  factory CustomerItem.fromJson(Map<String, dynamic> json) =>
      _$CustomerItemFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerItemToJson(this);
}

@JsonSerializable()
class SettingPoint {
  final String? name;
  final double? startValue;
  final double? endValue;
  final String? description;
  final String? id;
  final List<dynamic> domainEvents;

  SettingPoint({
    required this.name,
    required this.startValue,
    required this.endValue,
    required this.description,
    required this.id,
    required this.domainEvents,
  });

  factory SettingPoint.fromJson(Map<String, dynamic> json) =>
      _$SettingPointFromJson(json);

  Map<String, dynamic> toJson() => _$SettingPointToJson(this);
}
