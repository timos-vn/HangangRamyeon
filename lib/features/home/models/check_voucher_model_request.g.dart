// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_voucher_model_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVoucherModelRequest _$CheckVoucherModelRequestFromJson(
        Map<String, dynamic> json) =>
    CheckVoucherModelRequest(
      shopId: json['ShopId'] as String?,
      customerId: json['CustomerId'] as String?,
      voucherCode: json['VoucherCode'] as String,
      details: (json['Details'] as List<dynamic>)
          .map((e) => CommonDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckVoucherModelRequestToJson(
        CheckVoucherModelRequest instance) =>
    <String, dynamic>{
      'ShopId': instance.shopId,
      'CustomerId': instance.customerId,
      'VoucherCode': instance.voucherCode,
      'Details': instance.details.map((e) => e.toJson()).toList(),
    };
