// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherModel _$VoucherModelFromJson(Map<String, dynamic> json) => VoucherModel(
      succeeded: json['succeeded'] as bool,
      errors: json['errors'] as List<dynamic>,
      data: (json['data'] as List<dynamic>)
          .map((e) => VoucherItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoucherModelToJson(VoucherModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

VoucherItem _$VoucherItemFromJson(Map<String, dynamic> json) => VoucherItem(
      name: json['name'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      ruleType: (json['ruleType'] as num).toInt(),
      detailType: (json['detailType'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      maxUsage: (json['maxUsage'] as num?)?.toInt(),
      usage: (json['usage'] as num?)?.toInt(),
      voucherCode: json['voucherCode'] as String,
      imageUrl: json['imageUrl'] as String?,
      value: (json['value'] as num).toDouble(),
      details: json['details'] as List<dynamic>,
      rules: json['rules'] as List<dynamic>,
      status: (json['status'] as num).toInt(),
      shopId: json['shopId'] as String?,
      shop: json['shop'],
      created: json['created'] as String,
      createdBy: json['createdBy'] as String,
      lastModified: json['lastModified'] as String,
      lastModifiedBy: json['lastModifiedBy'] as String,
      deleted: json['deleted'] as String,
      deletedBy: json['deletedBy'] as String?,
      id: json['id'] as String,
      domainEvents: json['domainEvents'] as List<dynamic>,
    );

Map<String, dynamic> _$VoucherItemToJson(VoucherItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'ruleType': instance.ruleType,
      'detailType': instance.detailType,
      'type': instance.type,
      'maxUsage': instance.maxUsage,
      'usage': instance.usage,
      'voucherCode': instance.voucherCode,
      'imageUrl': instance.imageUrl,
      'value': instance.value,
      'details': instance.details,
      'rules': instance.rules,
      'status': instance.status,
      'shopId': instance.shopId,
      'shop': instance.shop,
      'created': instance.created,
      'createdBy': instance.createdBy,
      'lastModified': instance.lastModified,
      'lastModifiedBy': instance.lastModifiedBy,
      'deleted': instance.deleted,
      'deletedBy': instance.deletedBy,
      'id': instance.id,
      'domainEvents': instance.domainEvents,
    };
