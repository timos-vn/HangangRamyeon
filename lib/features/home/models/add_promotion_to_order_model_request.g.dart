// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_promotion_to_order_model_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromotionToOrderModelRequest _$AddPromotionToOrderModelRequestFromJson(
        Map<String, dynamic> json) =>
    AddPromotionToOrderModelRequest(
      shopId: json['shopId'] as String,
      customerId: json['customerId'] as String,
      promotionIds: (json['promotionIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      details: (json['details'] as List<dynamic>)
          .map((e) => AddPromotionDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddPromotionToOrderModelRequestToJson(
        AddPromotionToOrderModelRequest instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'customerId': instance.customerId,
      'promotionIds': instance.promotionIds,
      'details': instance.details.map((e) => e.toJson()).toList(),
    };

AddPromotionDetail _$AddPromotionDetailFromJson(Map<String, dynamic> json) =>
    AddPromotionDetail(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toDouble(),
    );

Map<String, dynamic> _$AddPromotionDetailToJson(AddPromotionDetail instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'salePrice': instance.salePrice,
    };
