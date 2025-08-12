import 'package:json_annotation/json_annotation.dart';

part 'update_order_response.g.dart';

@JsonSerializable()
class UpdateOrderResponse {
  final bool succeeded;
  final List<String> errors;
  final dynamic data; // vì data = null nên để dynamic, nếu sau này có kiểu cụ thể thì đổi lại

  UpdateOrderResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory UpdateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderResponseToJson(this);
}
