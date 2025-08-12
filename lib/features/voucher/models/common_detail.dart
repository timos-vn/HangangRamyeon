import 'package:json_annotation/json_annotation.dart';

part 'common_detail.g.dart';

@JsonSerializable()
class CommonDetail {
  @JsonKey(name: 'ProductId')
  final String productId;

  @JsonKey(name: 'Quantity')
  final int quantity;

  @JsonKey(name: 'SalePrice')
  final double salePrice;

  @JsonKey(name: 'Total')
  final double total;

  CommonDetail({
    required this.productId,
    required this.quantity,
    required this.salePrice,
    required this.total,
  });

  factory CommonDetail.fromJson(Map<String, dynamic> json) =>
      _$CommonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDetailToJson(this);
}
