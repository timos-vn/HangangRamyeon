// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderRequest _$UpdateOrderRequestFromJson(Map<String, dynamic> json) =>
    UpdateOrderRequest(
      id: json['id'] as String,
      shopId: json['shopId'] as String?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      invoiceCode: json['invoiceCode'] as String,
      customerPaid: (json['customerPaid'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      totalDisCount: (json['totalDisCount'] as num).toDouble(),
      totalPayment: (json['totalPayment'] as num).toDouble(),
      promotionIds: json['promotionIds'] as String?,
      total: (json['total'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      note: json['note'] as String?,
      customerId: json['customerId'] as String?,
      voucherCodeId: json['voucherCodeId'] as String?,
      details: (json['details'] as List<dynamic>)
          .map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
      changeDisCount: (json['changeDisCount'] as num).toDouble(),
      changeDisCountValue: (json['changeDisCountValue'] as num).toDouble(),
      changeDisCountType: (json['changeDisCountType'] as num).toInt(),
      pointUsed: (json['pointUsed'] as num).toInt(),
      Lot: json['Lot'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      totalCount: (json['totalCount'] as num).toInt(),
      buyerName: json['BuyerName'] as String?,
      buyerPhone: json['BuyerPhone'] as String?,
      buyerAddress: json['BuyerAddress'] as String?,
    );

Map<String, dynamic> _$UpdateOrderRequestToJson(UpdateOrderRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'saleDate': instance.saleDate.toIso8601String(),
      'invoiceCode': instance.invoiceCode,
      'customerPaid': instance.customerPaid,
      'totalAmount': instance.totalAmount,
      'changeAmount': instance.changeAmount,
      'totalDisCount': instance.totalDisCount,
      'totalPayment': instance.totalPayment,
      'promotionIds': instance.promotionIds,
      'total': instance.total,
      'discount': instance.discount,
      'note': instance.note,
      'customerId': instance.customerId,
      'voucherCodeId': instance.voucherCodeId,
      'details': instance.details.map((e) => e.toJson()).toList(),
      'changeDisCount': instance.changeDisCount,
      'changeDisCountValue': instance.changeDisCountValue,
      'changeDisCountType': instance.changeDisCountType,
      'pointUsed': instance.pointUsed,
      'Lot': instance.Lot,
      'name': instance.name,
      'address': instance.address,
      'totalCount': instance.totalCount,
      'BuyerName': instance.buyerName,
      'BuyerPhone': instance.buyerPhone,
      'BuyerAddress': instance.buyerAddress,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      productId: json['productId'] as String,
      productName: json['productName'] as String?,
      lot: json['lot'] as String?,
      isGift: (json['isGift'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      promotionIds: json['promotionIds'] as String?,
      salePrice: (json['salePrice'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'lot': instance.lot,
      'isGift': instance.isGift,
      'quantity': instance.quantity,
      'promotionIds': instance.promotionIds,
      'salePrice': instance.salePrice,
      'discount': instance.discount,
      'total': instance.total,
    };
