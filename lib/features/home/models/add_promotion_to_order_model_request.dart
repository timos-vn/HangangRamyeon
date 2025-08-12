import 'package:json_annotation/json_annotation.dart';

part 'add_promotion_to_order_model_request.g.dart';

@JsonSerializable(explicitToJson: true)
class AddPromotionToOrderModelRequest {
  final String shopId;
  final String customerId;
  final List<String> promotionIds;
  final List<AddPromotionDetail> details;

  AddPromotionToOrderModelRequest({
    required this.shopId,
    required this.customerId,
    required this.promotionIds,
    required this.details,
  });

  factory AddPromotionToOrderModelRequest.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionToOrderModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionToOrderModelRequestToJson(this);
}

@JsonSerializable()
class AddPromotionDetail {
  final String productId;
  final int quantity;
  final double salePrice;

  AddPromotionDetail({
    required this.productId,
    required this.quantity,
    required this.salePrice,
  });

  factory AddPromotionDetail.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionDetailToJson(this);
}
