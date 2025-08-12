import 'package:json_annotation/json_annotation.dart';

part 'update_order_request.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateOrderRequest {
  final String id;
  final String? shopId;
  final DateTime saleDate;
  final String invoiceCode;
  final double customerPaid;
  final double totalAmount;
  final double changeAmount;
  final double totalDisCount;
  final double totalPayment;
  final String? promotionIds;
  final double total;
  final double discount;
  final String? note;
  final String? customerId;
  final String? voucherCodeId;
  final List<Detail> details;
  final double changeDisCount;
  final double changeDisCountValue;
  final int changeDisCountType;
  final int pointUsed;
  final String? Lot;
  final String? name;
  final String? address;
  final int totalCount;
  @JsonKey(name: 'BuyerName')
  final String? buyerName;
  @JsonKey(name: 'BuyerPhone')
  final String? buyerPhone;
  @JsonKey(name: 'BuyerAddress')
  final String? buyerAddress;

  UpdateOrderRequest({
    required this.id,
    this.shopId,
    required this.saleDate,
    required this.invoiceCode,
    required this.customerPaid,
    required this.totalAmount,
    required this.changeAmount,
    required this.totalDisCount,
    required this.totalPayment,
    this.promotionIds,
    required this.total,
    required this.discount,
    this.note,
    this.customerId,
    this.voucherCodeId,
    required this.details,
    required this.changeDisCount,
    required this.changeDisCountValue,
    required this.changeDisCountType,
    required this.pointUsed,
    this.Lot,
    this.name,
    this.address,
    required this.totalCount,
    this.buyerName,
    this.buyerPhone,
    this.buyerAddress,
  });

  factory UpdateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateOrderRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Detail {
  final String productId;
  final String? productName;
  final String? lot;
  final int isGift;
  final int quantity;
  final String? promotionIds;
  final double salePrice;
  final double discount;
  final double total;

  Detail({
    required this.productId,
    this.productName,
    this.lot,
    required this.isGift,
    required this.quantity,
    this.promotionIds,
    required this.salePrice,
    required this.discount,
    required this.total,
  });

  factory Detail.fromJson(Map<String, dynamic> json) =>
      _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
