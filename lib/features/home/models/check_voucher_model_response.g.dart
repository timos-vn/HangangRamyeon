// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_voucher_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVoucherModelResponse _$CheckVoucherModelResponseFromJson(
        Map<String, dynamic> json) =>
    CheckVoucherModelResponse(
      succeeded: json['succeeded'] as bool,
      errors: json['errors'] as List<dynamic>,
      data: json['data'] == null
          ? null
          : VoucherData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckVoucherModelResponseToJson(
        CheckVoucherModelResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

VoucherData _$VoucherDataFromJson(Map<String, dynamic> json) => VoucherData(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      ruleType: (json['ruleType'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      maxUsage: (json['maxUsage'] as num?)?.toInt(),
      usage: (json['usage'] as num?)?.toInt(),
      voucherCode: json['voucherCode'] as String?,
      imageUrl: json['imageUrl'] as String?,
      value: (json['value'] as num).toDouble(),
      status: (json['status'] as num).toInt(),
      shopId: json['shopId'] as String?,
      detailType: (json['detailType'] as num).toInt(),
      rules: (json['rules'] as List<dynamic>)
          .map((e) => VoucherRule.fromJson(e as Map<String, dynamic>))
          .toList(),
      details: (json['details'] as List<dynamic>)
          .map((e) => VoucherDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoucherDataToJson(VoucherData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'ruleType': instance.ruleType,
      'type': instance.type,
      'maxUsage': instance.maxUsage,
      'usage': instance.usage,
      'voucherCode': instance.voucherCode,
      'imageUrl': instance.imageUrl,
      'value': instance.value,
      'status': instance.status,
      'shopId': instance.shopId,
      'detailType': instance.detailType,
      'rules': instance.rules.map((e) => e.toJson()).toList(),
      'details': instance.details.map((e) => e.toJson()).toList(),
    };

VoucherRule _$VoucherRuleFromJson(Map<String, dynamic> json) => VoucherRule(
      id: json['id'] as String?,
      keyId: json['keyId'] as String?,
      ruleValue: (json['ruleValue'] as num?)?.toDouble(),
      minRuleValue: (json['minRuleValue'] as num?)?.toDouble(),
      maxRuleValue: (json['maxRuleValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VoucherRuleToJson(VoucherRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keyId': instance.keyId,
      'ruleValue': instance.ruleValue,
      'minRuleValue': instance.minRuleValue,
      'maxRuleValue': instance.maxRuleValue,
    };

VoucherDetail _$VoucherDetailFromJson(Map<String, dynamic> json) =>
    VoucherDetail(
      id: json['id'] as String,
      productId: json['productId'] as String?,
      promotionDetailGroup: (json['promotionDetailGroup'] as num).toInt(),
      promotionDetailGroupType:
          (json['promotionDetailGroupType'] as num).toInt(),
      value: (json['value'] as num).toDouble(),
      valueType: (json['valueType'] as num).toInt(),
      maxUsage: (json['maxUsage'] as num).toInt(),
      usage: (json['usage'] as num).toInt(),
      maxTotalDisCount: (json['maxTotalDisCount'] as num).toInt(),
    );

Map<String, dynamic> _$VoucherDetailToJson(VoucherDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'promotionDetailGroup': instance.promotionDetailGroup,
      'promotionDetailGroupType': instance.promotionDetailGroupType,
      'value': instance.value,
      'valueType': instance.valueType,
      'maxUsage': instance.maxUsage,
      'usage': instance.usage,
      'maxTotalDisCount': instance.maxTotalDisCount,
    };
