import 'package:json_annotation/json_annotation.dart';

part 'voucher_model.g.dart';

@JsonSerializable()
class VoucherModel {
  final bool succeeded;
  final List<dynamic> errors;
  final List<VoucherItem> data;

  VoucherModel({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherModelToJson(this);
}

@JsonSerializable()
class VoucherItem {
  final String name;
  final String description;
  final String? startDate;
  final String? endDate;
  final int ruleType;
  final int detailType;
  final int type;
  final int? maxUsage;
  final int? usage;
  final String voucherCode;
  final String? imageUrl;
  final double value;
  final List<dynamic> details;
  final List<dynamic> rules;
  final int status;
  final String? shopId;
  final dynamic shop;
  final String created;
  final String createdBy;
  final String lastModified;
  final String lastModifiedBy;
  final String deleted;
  final String? deletedBy;
  final String id;
  final List<dynamic> domainEvents;

  VoucherItem({
    required this.name,
    required this.description,
    this.startDate,
    this.endDate,
    required this.ruleType,
    required this.detailType,
    required this.type,
    this.maxUsage,
    this.usage,
    required this.voucherCode,
    this.imageUrl,
    required this.value,
    required this.details,
    required this.rules,
    required this.status,
    this.shopId,
    this.shop,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.deleted,
    this.deletedBy,
    required this.id,
    required this.domainEvents,
  });

  factory VoucherItem.fromJson(Map<String, dynamic> json) =>
      _$VoucherItemFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherItemToJson(this);
}
