// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_promotion_model_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPromotionModelRequest _$CheckPromotionModelRequestFromJson(
        Map<String, dynamic> json) =>
    CheckPromotionModelRequest(
      shopId: json['shopId'] as String?,
      customerId: json['customerId'] as String?,
      details: (json['details'] as List<dynamic>)
          .map((e) => CommonDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckPromotionModelRequestToJson(
        CheckPromotionModelRequest instance) =>
    <String, dynamic>{
      'shopId': instance.shopId,
      'customerId': instance.customerId,
      'details': instance.details.map((e) => e.toJson()).toList(),
    };
