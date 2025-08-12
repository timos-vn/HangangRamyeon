import 'package:json_annotation/json_annotation.dart';

part 'create_order_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateOrderRequest {
  final String? id;
  final String? invoiceCode;
  final String? shopId;
  final DateTime saleDate;
  final double discount;
  final String? note;
  final String? Lot;
  final int totalCount;
  final double total;
  final String? promotionIds;
  final int pointUsed;
  final double customerPaid;
  final List<DetailItem> details;
  final double changeDisCount;
  final double changeDisCountValue;
  final int changeDisCountType;
  final double totalPayment;
  final int totalDisCountLine;
  final double totalDisCount;
  final String? voucherCodeId;
  final String? voucherCode;
  final String? customerId;

  CreateOrderRequest({
    this.id,
    this.invoiceCode,
    this.shopId,
    required this.saleDate,
    required this.discount,
    this.note,
    this.Lot,
    required this.totalCount,
    required this.total,
    this.promotionIds,
    required this.pointUsed,
    required this.customerPaid,
    required this.details,
    required this.changeDisCount,
    required this.changeDisCountValue,
    required this.changeDisCountType,
    required this.totalPayment,
    required this.totalDisCountLine,
    required this.totalDisCount,
    this.voucherCodeId,
    this.voucherCode,
    this.customerId,
  });

  factory CreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateOrderRequestToJson(this);
}

@JsonSerializable()
class DetailItem {
  final String id;
  final String productId;
  final String? name;
  final int quantity;
  final double salePrice;
  final double total;
  final int isGift;
  final double disCount;

  DetailItem({
    required this.id,
    required this.productId,
    this.name,
    required this.quantity,
    required this.salePrice,
    required this.total,
    required this.isGift,
    required this.disCount,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) =>
      _$DetailItemFromJson(json);

  Map<String, dynamic> toJson() => _$DetailItemToJson(this);
}
