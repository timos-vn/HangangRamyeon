// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: TransactionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

TransactionData _$TransactionDataFromJson(Map<String, dynamic> json) =>
    TransactionData(
      totalCount: (json['totalCount'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      hasPrevious: json['hasPrevious'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      items: (json['items'] as List<dynamic>)
          .map((e) => TransactionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionDataToJson(TransactionData instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'pageSize': instance.pageSize,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'hasPrevious': instance.hasPrevious,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };

TransactionItem _$TransactionItemFromJson(Map<String, dynamic> json) =>
    TransactionItem(
      id: json['id'] as String,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      invoiceCode: json['invoiceCode'] as String?,
      saleDate: DateTime.parse(json['saleDate'] as String),
      buyerName: json['buyerName'] as String?,
      buyerId: json['buyerId'] as String?,
      customerPaid: (json['customerPaid'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      changeAmount: (json['changeAmount'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      created: DateTime.parse(json['created'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$TransactionItemToJson(TransactionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'invoiceCode': instance.invoiceCode,
      'saleDate': instance.saleDate.toIso8601String(),
      'buyerName': instance.buyerName,
      'buyerId': instance.buyerId,
      'customerPaid': instance.customerPaid,
      'totalAmount': instance.totalAmount,
      'changeAmount': instance.changeAmount,
      'discount': instance.discount,
      'created': instance.created.toIso8601String(),
      'note': instance.note,
    };
