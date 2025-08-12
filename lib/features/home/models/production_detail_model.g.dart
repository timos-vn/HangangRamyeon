// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionDetailModel _$ProductionDetailModelFromJson(
        Map<String, dynamic> json) =>
    ProductionDetailModel(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: ProductionDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductionDetailModelToJson(
        ProductionDetailModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data.toJson(),
    };

ProductionDetailData _$ProductionDetailDataFromJson(
        Map<String, dynamic> json) =>
    ProductionDetailData(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      description: json['description'] as String?,
      supplierId: json['supplierId'] as String?,
      supplierName: json['supplierName'] as String?,
      weight: (json['weight'] as num).toDouble(),
      unit: json['unit'] as String,
      manufactureDate: DateTime.parse(json['manufactureDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      importPrice: (json['importPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      shopId: json['shopId'] as String,
      shopName: json['shopName'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      remainingQuantity: (json['remainingQuantity'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      attributes: json['attributes'] as List<dynamic>,
      productMaterials: (json['productMaterials'] as List<dynamic>)
          .map((e) => ProductMaterial.fromJson(e as Map<String, dynamic>))
          .toList(),
      stockQuantityByShops: json['stockQuantityByShops'] as List<dynamic>,
      isGift: (json['isGift'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      promotionIds: json['promotionIds'] as String? ?? '',
      disCount: (json['disCount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProductionDetailDataToJson(
        ProductionDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'description': instance.description,
      'supplierId': instance.supplierId,
      'supplierName': instance.supplierName,
      'weight': instance.weight,
      'unit': instance.unit,
      'manufactureDate': instance.manufactureDate.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'importPrice': instance.importPrice,
      'salePrice': instance.salePrice,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'quantity': instance.quantity,
      'remainingQuantity': instance.remainingQuantity,
      'images': instance.images,
      'attributes': instance.attributes,
      'productMaterials':
          instance.productMaterials.map((e) => e.toJson()).toList(),
      'stockQuantityByShops': instance.stockQuantityByShops,
      'isGift': instance.isGift,
      'total': instance.total,
      'promotionIds': instance.promotionIds,
      'disCount': instance.disCount,
    };

ProductMaterial _$ProductMaterialFromJson(Map<String, dynamic> json) =>
    ProductMaterial(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      weight: (json['weight'] as num).toDouble(),
      unitId: json['unitId'] as String,
      images: json['images'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      isExpired: json['isExpired'] as bool,
    );

Map<String, dynamic> _$ProductMaterialToJson(ProductMaterial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'description': instance.description,
      'weight': instance.weight,
      'unitId': instance.unitId,
      'images': instance.images,
      'quantity': instance.quantity,
      'isExpired': instance.isExpired,
    };
