import 'package:json_annotation/json_annotation.dart';

part 'create_order_response.g.dart';

@JsonSerializable()
class CreateOrderResponse {
  final bool succeeded;
  final List<String> errors;
  final CreateOrderData data;

  CreateOrderResponse({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);
}

@JsonSerializable()
class CreateOrderData {
  final String id;
  final String code;

  CreateOrderData({
    required this.id,
    required this.code,
  });

  factory CreateOrderData.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderDataToJson(this);
}
