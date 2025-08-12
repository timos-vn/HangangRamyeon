import 'package:json_annotation/json_annotation.dart';

part 'add_promotion_to_order_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AddPromotionToOrderModelResponse {
  final bool succeeded;
  final List<String>? errors;
  final AddPromotionToOrderData? data;

  AddPromotionToOrderModelResponse({
    required this.succeeded,
    this.errors,
    this.data,
  });

  factory AddPromotionToOrderModelResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionToOrderModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionToOrderModelResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AddPromotionToOrderData {
  final String shopId;
  final String customerId;
  final String promotionIds;
  final List<AddPromotionToOrderDetail> details;
  final double total;
  final double disCount;
  final double totalDisCountProduct;

  AddPromotionToOrderData({
    required this.shopId,
    required this.customerId,
    required this.promotionIds,
    required this.details,
    required this.total,
    required this.disCount,
    required this.totalDisCountProduct,
  });

  factory AddPromotionToOrderData.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionToOrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionToOrderDataToJson(this);
}

@JsonSerializable()
class AddPromotionToOrderDetail {
  final String productId;
  final int isGift;
  final int quantity;
  final double salePrice;
  final double salePriceDisCount;
  final String promotionIds;
  final double total;
  final double disCount;

  AddPromotionToOrderDetail({
    required this.productId,
    required this.isGift,
    required this.quantity,
    required this.salePrice,
    required this.salePriceDisCount,
    required this.promotionIds,
    required this.total,
    required this.disCount,
  });

  factory AddPromotionToOrderDetail.fromJson(Map<String, dynamic> json) =>
      _$AddPromotionToOrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AddPromotionToOrderDetailToJson(this);
}
