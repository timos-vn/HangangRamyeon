// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductionResponse _$ProductionResponseFromJson(Map<String, dynamic> json) =>
    ProductionResponse(
      succeeded: json['succeeded'] as bool,
      errors: json['errors'] as List<dynamic>,
      data: json['data'] == null
          ? null
          : ProductionData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductionResponseToJson(ProductionResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data?.toJson(),
    };

ProductionData _$ProductionDataFromJson(Map<String, dynamic> json) =>
    ProductionData(
      items: (json['items'] as List<dynamic>)
          .map((e) => ProductItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$ProductionDataToJson(ProductionData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'pageNumber': instance.pageNumber,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as String,
      code: json['code'] as String?,
      name: json['name'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      description: json['description'] as String?,
      supplierId: json['supplierId'] as String?,
      supplierName: json['supplierName'] as String?,
      weight: (json['weight'] as num).toDouble(),
      unit: json['unit'] as String?,
      manufactureDate: json['manufactureDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      importPrice: (json['importPrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      remainingQuantity: (json['remainingQuantity'] as num?)?.toDouble(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
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
      'manufactureDate': instance.manufactureDate,
      'expiryDate': instance.expiryDate,
      'importPrice': instance.importPrice,
      'salePrice': instance.salePrice,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'remainingQuantity': instance.remainingQuantity,
      'images': instance.images,
    };
