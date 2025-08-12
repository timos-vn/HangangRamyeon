// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderRequest _$CreateOrderRequestFromJson(Map<String, dynamic> json) =>
    CreateOrderRequest(
      id: json['id'] as String?,
      invoiceCode: json['invoiceCode'] as String?,
      shopId: json['shopId'] as String?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      discount: (json['discount'] as num).toDouble(),
      note: json['note'] as String?,
      Lot: json['Lot'] as String?,
      totalCount: (json['totalCount'] as num).toInt(),
      total: (json['total'] as num).toDouble(),
      promotionIds: json['promotionIds'] as String?,
      pointUsed: (json['pointUsed'] as num).toInt(),
      customerPaid: (json['customerPaid'] as num).toDouble(),
      details: (json['details'] as List<dynamic>)
          .map((e) => DetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      changeDisCount: (json['changeDisCount'] as num).toDouble(),
      changeDisCountValue: (json['changeDisCountValue'] as num).toDouble(),
      changeDisCountType: (json['changeDisCountType'] as num).toInt(),
      totalPayment: (json['totalPayment'] as num).toDouble(),
      totalDisCountLine: (json['totalDisCountLine'] as num).toInt(),
      totalDisCount: (json['totalDisCount'] as num).toDouble(),
      voucherCodeId: json['voucherCodeId'] as String?,
      voucherCode: json['voucherCode'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$CreateOrderRequestToJson(CreateOrderRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoiceCode': instance.invoiceCode,
      'shopId': instance.shopId,
      'saleDate': instance.saleDate.toIso8601String(),
      'discount': instance.discount,
      'note': instance.note,
      'Lot': instance.Lot,
      'totalCount': instance.totalCount,
      'total': instance.total,
      'promotionIds': instance.promotionIds,
      'pointUsed': instance.pointUsed,
      'customerPaid': instance.customerPaid,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'changeDisCount': instance.changeDisCount,
      'changeDisCountValue': instance.changeDisCountValue,
      'changeDisCountType': instance.changeDisCountType,
      'totalPayment': instance.totalPayment,
      'totalDisCountLine': instance.totalDisCountLine,
      'totalDisCount': instance.totalDisCount,
      'voucherCodeId': instance.voucherCodeId,
      'voucherCode': instance.voucherCode,
      'customerId': instance.customerId,
    };

DetailItem _$DetailItemFromJson(Map<String, dynamic> json) => DetailItem(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      salePrice: (json['salePrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      isGift: (json['isGift'] as num).toInt(),
      disCount: (json['disCount'] as num).toDouble(),
    );

Map<String, dynamic> _$DetailItemToJson(DetailItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'quantity': instance.quantity,
      'salePrice': instance.salePrice,
      'total': instance.total,
      'isGift': instance.isGift,
      'disCount': instance.disCount,
    };
