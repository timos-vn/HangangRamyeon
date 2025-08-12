import 'package:json_annotation/json_annotation.dart';

part 'banner_and_post_model.g.dart';

@JsonSerializable()
class BannerAndPostModel {
  final bool succeeded;
  final List<dynamic> errors;
  final PaginatedBannerData data;

  BannerAndPostModel({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory BannerAndPostModel.fromJson(Map<String, dynamic> json) =>
      _$BannerAndPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerAndPostModelToJson(this);
}

@JsonSerializable()
class PaginatedBannerData {
  final List<BannerItem> items;
  final int pageNumber;
  final int totalPages;
  final int totalCount;
  final bool hasPreviousPage;
  final bool hasNextPage;

  PaginatedBannerData({
    required this.items,
    required this.pageNumber,
    required this.totalPages,
    required this.totalCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PaginatedBannerData.fromJson(Map<String, dynamic> json) =>
      _$PaginatedBannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedBannerDataToJson(this);
}

@JsonSerializable()
class BannerItem {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String status;
  final bool isFeatured;
  final String created;
  final String createdBy;

  BannerItem({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.status,
    required this.isFeatured,
    required this.created,
    required this.createdBy,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) =>
      _$BannerItemFromJson(json);

  Map<String, dynamic> toJson() => _$BannerItemToJson(this);
}
