// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailTransactionResponse _$DetailTransactionResponseFromJson(
        Map<String, dynamic> json) =>
    DetailTransactionResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'] == null
          ? null
          : DetailTransactionData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailTransactionResponseToJson(
        DetailTransactionResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

DetailTransactionData _$DetailTransactionDataFromJson(
        Map<String, dynamic> json) =>
    DetailTransactionData(
      id: json['id'] as String,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      invoiceCode: json['invoiceCode'] as String?,
      buyerName: json['buyerName'] as String?,
      customerPaid: (json['customerPaid'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      totalDisCount: (json['totalDisCount'] as num).toDouble(),
      totalPayment: (json['totalPayment'] as num).toDouble(),
      promotionIds: json['promotionIds'] as String?,
      totalDiscountLine: (json['totalDiscountLine'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      note: json['note'] as String?,
      customerId: json['customerId'] as String?,
      voucherCodeId: json['voucherCodeId'] as String?,
      details: (json['details'] as List<dynamic>)
          .map((e) => DetailTransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailTransactionDataToJson(
        DetailTransactionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'saleDate': instance.saleDate.toIso8601String(),
      'invoiceCode': instance.invoiceCode,
      'buyerName': instance.buyerName,
      'customerPaid': instance.customerPaid,
      'totalAmount': instance.totalAmount,
      'changeAmount': instance.changeAmount,
      'totalDisCount': instance.totalDisCount,
      'totalPayment': instance.totalPayment,
      'promotionIds': instance.promotionIds,
      'totalDiscountLine': instance.totalDiscountLine,
      'total': instance.total,
      'discount': instance.discount,
      'note': instance.note,
      'customerId': instance.customerId,
      'voucherCodeId': instance.voucherCodeId,
      'details': instance.details.map((e) => e.toJson()).toList(),
    };

DetailTransactionItem _$DetailTransactionItemFromJson(
        Map<String, dynamic> json) =>
    DetailTransactionItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String?,
      lot: json['lot'] as String?,
      isGift: (json['isGift'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      promotionIds: json['promotionIds'] as String?,
      salePrice: (json['salePrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      productImages: (json['productImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DetailTransactionItemToJson(
        DetailTransactionItem instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'lot': instance.lot,
      'isGift': instance.isGift,
      'quantity': instance.quantity,
      'promotionIds': instance.promotionIds,
      'salePrice': instance.salePrice,
      'discount': instance.discount,
      'total': instance.total,
      'productImages': instance.productImages,
    };
