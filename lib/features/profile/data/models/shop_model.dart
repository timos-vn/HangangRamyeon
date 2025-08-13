import 'package:json_annotation/json_annotation.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopResponse {
  final bool succeeded;
  final List<String> errors;
  final ShopData data;

  ShopResponse({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShopResponseToJson(this);
}

@JsonSerializable()
class ShopData {
  final List<Shop> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  ShopData({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory ShopData.fromJson(Map<String, dynamic> json) =>
      _$ShopDataFromJson(json);
  Map<String, dynamic> toJson() => _$ShopDataToJson(this);
}

@JsonSerializable()
class Shop {
  final String id;
  final String code;
  final String name;
  final String address;
  final String phoneNumber;
  final String taxCode;
  final String bankName;
  final String bankNumber;

  Shop({
    required this.id,
    required this.code,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.taxCode,
    required this.bankName,
    required this.bankNumber,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
