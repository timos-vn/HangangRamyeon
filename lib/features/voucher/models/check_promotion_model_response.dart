import 'package:json_annotation/json_annotation.dart';

part 'check_promotion_model_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckPromotionModelResponse {
  final bool succeeded;
  final List<dynamic> errors;
  final List<PromotionData> data;

  CheckPromotionModelResponse({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory CheckPromotionModelResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPromotionModelResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckPromotionModelResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PromotionData {
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
  final List<PromotionRule> rules;
  final List<PromotionDetail> details;

  PromotionData({
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

  factory PromotionData.fromJson(Map<String, dynamic> json) =>
      _$PromotionDataFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDataToJson(this);
}

@JsonSerializable()
class PromotionRule {
  final String id;
  final String? keyId;
  final double? ruleValue;
  final double? minRuleValue;
  final double? maxRuleValue;

  PromotionRule({
    required this.id,
    this.keyId,
    this.ruleValue,
    this.minRuleValue,
    this.maxRuleValue,
  });

  factory PromotionRule.fromJson(Map<String, dynamic> json) =>
      _$PromotionRuleFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionRuleToJson(this);
}

@JsonSerializable()
class PromotionDetail {
  final String id;
  final String? productId;
  final int promotionDetailGroup;
  final int promotionDetailGroupType;
  final double value;
  final int valueType;
  final int maxUsage;
  final int usage;
  final int maxTotalDisCount;

  PromotionDetail({
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

  factory PromotionDetail.fromJson(Map<String, dynamic> json) =>
      _$PromotionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDetailToJson(this);
}
