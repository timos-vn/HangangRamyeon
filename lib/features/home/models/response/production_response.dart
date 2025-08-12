import 'package:json_annotation/json_annotation.dart';

part 'production_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductionResponse {
  final bool succeeded;
  final List<dynamic> errors;
  final ProductionData? data;

  ProductionResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory ProductionResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductionData {
  final List<ProductItem> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  ProductionData({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory ProductionData.fromJson(Map<String, dynamic> json) =>
      _$ProductionDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductItem {
  final String id;
  final String? code;
  final String? name;
  final String? categoryId;
  final String? categoryName;
  final String? description;
  final String? supplierId;
  final String? supplierName;
  final double weight;
  final String? unit;
  final String? manufactureDate;
  final String? expiryDate;
  final double importPrice;
  final double salePrice;
  final String? shopId;
  final String? shopName;
  final double? remainingQuantity;
  final List<String> images;

  ProductItem({
    required this.id,
    required this.code,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    this.supplierId,
    this.supplierName,
    required this.weight,
    required this.unit,
    required this.manufactureDate,
    required this.expiryDate,
    required this.importPrice,
    required this.salePrice,
    required this.shopId,
    required this.shopName,
    this.remainingQuantity,
    required this.images,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) =>
      _$ProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemToJson(this);
}
