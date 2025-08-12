// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_promotion_to_order_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPromotionToOrderModelResponse _$AddPromotionToOrderModelResponseFromJson(
        Map<String, dynamic> json) =>
    AddPromotionToOrderModelResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : AddPromotionToOrderData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddPromotionToOrderModelResponseToJson(
        AddPromotionToOrderModelResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

AddPromotionToOrderData _$AddPromotionToOrderDataFromJson(
        Map<String, dynamic> json) =>
    AddPromotionToOrderData(
      shopId: json['shopId'] as String,
      customerId: json['customerId'] as String,
      promotionIds: json['promotionIds'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) =>
              AddPromotionToOrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toDouble(),
      disCount: (json['disCount'] as num).toDouble(),
      totalDisCountProduct: (json['totalDisCountProduct'] as num).toDouble(),
    );

Map<String, dynamic> _$AddPromotionToOrderDataToJson(
        AddPromotionToOrderData instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'customerId': instance.customerId,
      'promotionIds': instance.promotionIds,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'total': instance.total,
      'disCount': instance.disCount,
      'totalDisCountProduct': instance.totalDisCountProduct,
    };

AddPromotionToOrderDetail _$AddPromotionToOrderDetailFromJson(
        Map<String, dynamic> json) =>
    AddPromotionToOrderDetail(
      productId: json['productId'] as String,
      isGift: (json['isGift'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toDouble(),
      salePriceDisCount: (json['salePriceDisCount'] as num).toDouble(),
      promotionIds: json['promotionIds'] as String,
      total: (json['total'] as num).toDouble(),
      disCount: (json['disCount'] as num).toDouble(),
    );

Map<String, dynamic> _$AddPromotionToOrderDetailToJson(
        AddPromotionToOrderDetail instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'isGift': instance.isGift,
      'quantity': instance.quantity,
      'salePrice': instance.salePrice,
      'salePriceDisCount': instance.salePriceDisCount,
      'promotionIds': instance.promotionIds,
      'total': instance.total,
      'disCount': instance.disCount,
    };
