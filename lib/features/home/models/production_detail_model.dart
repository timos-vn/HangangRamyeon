import 'package:json_annotation/json_annotation.dart';

part 'production_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductionDetailModel {
  final bool succeeded;
  final List<String> errors;
  final ProductionDetailData data;

  ProductionDetailModel({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory ProductionDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionDetailModelToJson(this);

  ProductionDetailModel copyWith({
    bool? succeeded,
    List<String>? errors,
    ProductionDetailData? data,
  }) {
    return ProductionDetailModel(
      succeeded: succeeded ?? this.succeeded,
      errors: errors ?? this.errors,
      data: data ?? this.data,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductionDetailData {
  final String id;
  final String code;
  final String name;
  final String categoryId;
  final String categoryName;
  final String? description;
  final String? supplierId;
  final String? supplierName;
  final double weight;
  final String unit;
  final DateTime manufactureDate;
  final DateTime expiryDate;
  final double importPrice;
  final double salePrice;
  final String shopId;
  final String? shopName;
  @JsonKey(defaultValue: 1)
  final int quantity;
  final double? remainingQuantity;
  final List<String> images;
  final List<dynamic> attributes;
  final List<ProductMaterial> productMaterials;
  final List<dynamic> stockQuantityByShops;
  @JsonKey(defaultValue: 0)
  final int isGift;
  @JsonKey(defaultValue: 0)
  final double total;
  @JsonKey(defaultValue: '')
  final String promotionIds;
  @JsonKey(defaultValue: 0)
  final double disCount;

  ProductionDetailData({
    required this.id,
    required this.code,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    this.description,
    this.supplierId,
    this.supplierName,
    required this.weight,
    required this.unit,
    required this.manufactureDate,
    required this.expiryDate,
    required this.importPrice,
    required this.salePrice,
    required this.shopId,
    this.shopName,
    required this.quantity,
    this.remainingQuantity,
    required this.images,
    required this.attributes,
    required this.productMaterials,
    required this.stockQuantityByShops,
    this.isGift = 0,
    this.total = 0,
    this.promotionIds = '',
    this.disCount = 0,
  });

  factory ProductionDetailData.fromJson(Map<String, dynamic> json) =>
      _$ProductionDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionDetailDataToJson(this);

  ProductionDetailData copyWith({
    String? id,
    String? code,
    String? name,
    String? categoryId,
    String? categoryName,
    String? description,
    String? supplierId,
    String? supplierName,
    double? weight,
    String? unit,
    DateTime? manufactureDate,
    DateTime? expiryDate,
    double? importPrice,
    double? salePrice,
    String? shopId,
    String? shopName,
    int? quantity,
    double? remainingQuantity,
    List<String>? images,
    List<dynamic>? attributes,
    List<ProductMaterial>? productMaterials,
    List<dynamic>? stockQuantityByShops,
    int? isGift,
    double? total,
    String? promotionIds,
    double? disCount,
  }) {
    return ProductionDetailData(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      description: description ?? this.description,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      weight: weight ?? this.weight,
      unit: unit ?? this.unit,
      manufactureDate: manufactureDate ?? this.manufactureDate,
      expiryDate: expiryDate ?? this.expiryDate,
      importPrice: importPrice ?? this.importPrice,
      salePrice: salePrice ?? this.salePrice,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      quantity: quantity ?? this.quantity,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      images: images ?? this.images,
      attributes: attributes ?? this.attributes,
      productMaterials: productMaterials ?? this.productMaterials,
      stockQuantityByShops: stockQuantityByShops ?? this.stockQuantityByShops,
      isGift: isGift ?? this.isGift,
      total: total ?? this.total,
      promotionIds: promotionIds ?? this.promotionIds,
      disCount: disCount ?? this.disCount,
    );
  }
}

@JsonSerializable()
class ProductMaterial {
  final String id;
  final String code;
  final String name;
  final String description;
  final double weight;
  final String unitId;
  final String images;
  final double quantity;
  final bool isExpired;

  ProductMaterial({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.weight,
    required this.unitId,
    required this.images,
    required this.quantity,
    required this.isExpired,
  });

  factory ProductMaterial.fromJson(Map<String, dynamic> json) =>
      _$ProductMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMaterialToJson(this);

  ProductMaterial copyWith({
    String? id,
    String? code,
    String? name,
    String? description,
    double? weight,
    String? unitId,
    String? images,
    double? quantity,
    bool? isExpired,
  }) {
    return ProductMaterial(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      weight: weight ?? this.weight,
      unitId: unitId ?? this.unitId,
      images: images ?? this.images,
      quantity: quantity ?? this.quantity,
      isExpired: isExpired ?? this.isExpired,
    );
  }
}