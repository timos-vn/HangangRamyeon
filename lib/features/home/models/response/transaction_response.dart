import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  final bool succeeded;
  final List<String> errors;
  final TransactionData data;

  TransactionResponse({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}

@JsonSerializable()
class TransactionData {
  final int totalCount;
  final int pageSize;
  final int currentPage;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNextPage;
  final List<TransactionItem> items;

  TransactionData({
    required this.totalCount,
    required this.pageSize,
    required this.currentPage,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNextPage,
    required this.items,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDataToJson(this);
}

@JsonSerializable()
class TransactionItem {
  final String id;
  final String? shopId;
  final String? shopName;
  final String? invoiceCode;
  final DateTime saleDate;
  final String? buyerName;
  final String? buyerId;
  final double customerPaid;
  final double totalAmount;
  final double changeAmount;
  final double discount;
  final DateTime created;
  final String? note;

  TransactionItem({
    required this.id,
    this.shopId,
    this.shopName,
    this.invoiceCode,
    required this.saleDate,
    this.buyerName,
    this.buyerId,
    required this.customerPaid,
    required this.totalAmount,
    required this.changeAmount,
    required this.discount,
    required this.created,
    this.note,
  });

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionItemToJson(this);
}
