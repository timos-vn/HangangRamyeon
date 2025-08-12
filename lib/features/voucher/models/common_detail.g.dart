// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonDetail _$CommonDetailFromJson(Map<String, dynamic> json) => CommonDetail(
      productId: json['ProductId'] as String,
      quantity: (json['Quantity'] as num).toInt(),
      salePrice: (json['SalePrice'] as num).toDouble(),
      total: (json['Total'] as num).toDouble(),
    );

Map<String, dynamic> _$CommonDetailToJson(CommonDetail instance) =>
    <String, dynamic>{
      'ProductId': instance.productId,
      'Quantity': instance.quantity,
      'SalePrice': instance.salePrice,
      'Total': instance.total,
    };
