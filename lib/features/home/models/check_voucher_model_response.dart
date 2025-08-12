import 'package:json_annotation/json_annotation.dart';

part 'check_voucher_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckVoucherModelResponse {
  final bool succeeded;
  final List<dynamic> errors;
  final VoucherData? data;

  CheckVoucherModelResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory CheckVoucherModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckVoucherModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckVoucherModelResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VoucherData {
  final String id;
  final String name;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final int ruleType;
  final int type;
  final int? maxUsage;
  final int? usage;
  final String? voucherCode;
  final String? imageUrl;
  final double value;
  final int status;
  final String? shopId;
  final int detailType;
  final List<VoucherRule> rules;
  final List<VoucherDetail> details;

  VoucherData({
    required this.id,
    required this.name,
    required this.description,
    this.startDate,
    this.endDate,
    required this.ruleType,
    required this.type,
    this.maxUsage,
    this.usage,
    required this.voucherCode,
    this.imageUrl,
    required this.value,
    required this.status,
    required this.shopId,
    required this.detailType,
    required this.rules,
    required this.details,
  });

  factory VoucherData.fromJson(Map<String, dynamic> json) =>
      _$VoucherDataFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDataToJson(this);
}

@JsonSerializable()
class VoucherRule {
  final String? id;
  final String? keyId;
  final double? ruleValue;
  final double? minRuleValue;
  final double? maxRuleValue;

  VoucherRule({
    this.id,
    this.keyId,
    this.ruleValue,
    this.minRuleValue,
    this.maxRuleValue,
  });

  factory VoucherRule.fromJson(Map<String, dynamic> json) =>
      _$VoucherRuleFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRuleToJson(this);
}

@JsonSerializable()
class VoucherDetail {
  final String id;
  final String? productId;
  final int promotionDetailGroup;
  final int promotionDetailGroupType;
  final double value;
  final int valueType;
  final int maxUsage;
  final int usage;
  final int maxTotalDisCount;

  VoucherDetail({
    required this.id,
    this.productId,
    required this.promotionDetailGroup,
    required this.promotionDetailGroupType,
    required this.value,
    required this.valueType,
    required this.maxUsage,
    required this.usage,
    required this.maxTotalDisCount,
  });

  factory VoucherDetail.fromJson(Map<String, dynamic> json) =>
      _$VoucherDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDetailToJson(this);
}
