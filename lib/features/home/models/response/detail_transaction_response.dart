import 'package:json_annotation/json_annotation.dart';

part 'detail_transaction_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailTransactionResponse {
  final bool succeeded;
  final List<String> errors;
  final DetailTransactionData? data;

  DetailTransactionResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory DetailTransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailTransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailTransactionResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DetailTransactionData {
  final String id;
  final String? shopId;
  final String? shopName;
  final DateTime saleDate;
  final String? invoiceCode;
  final String? buyerName;
  final double customerPaid;
  final double totalAmount;
  final double changeAmount;
  final double totalDisCount;
  final double totalPayment;
  final String? promotionIds;
  final double totalDiscountLine;
  final double total;
  final double discount;
  final String? note;
  final String? customerId;
  final String? voucherCodeId;
  final List<DetailTransactionItem> details;

  DetailTransactionData({
    required this.id,
    this.shopId,
    this.shopName,
    required this.saleDate,
    this.invoiceCode,
    this.buyerName,
    required this.customerPaid,
    required this.totalAmount,
    required this.changeAmount,
    required this.totalDisCount,
    required this.totalPayment,
    this.promotionIds,
    required this.totalDiscountLine,
    required this.total,
    required this.discount,
    this.note,
    this.customerId,
    this.voucherCodeId,
    required this.details,
  });

  factory DetailTransactionData.fromJson(Map<String, dynamic> json) =>
      _$DetailTransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$DetailTransactionDataToJson(this);
}

@JsonSerializable()
class DetailTransactionItem {
  final String productId;
  final String? productName;
  final String? lot;
  final int isGift;
  final int quantity;
  final String? promotionIds;
  final double salePrice;
  final double discount;
  final double total;
  final List<String>? productImages;

  DetailTransactionItem({
    required this.productId,
    this.productName,
    this.lot,
    required this.isGift,
    required this.quantity,
    this.promotionIds,
    required this.salePrice,
    required this.discount,
    required this.total,
    this.productImages,
  });

  factory DetailTransactionItem.fromJson(Map<String, dynamic> json) =>
      _$DetailTransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$DetailTransactionItemToJson(this);
}
