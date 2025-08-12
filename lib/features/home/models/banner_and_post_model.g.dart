// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_and_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerAndPostModel _$BannerAndPostModelFromJson(Map<String, dynamic> json) =>
    BannerAndPostModel(
      succeeded: json['succeeded'] as bool,
      errors: json['errors'] as List<dynamic>,
      data: PaginatedBannerData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BannerAndPostModelToJson(BannerAndPostModel instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

PaginatedBannerData _$PaginatedBannerDataFromJson(Map<String, dynamic> json) =>
    PaginatedBannerData(
      items: (json['items'] as List<dynamic>)
          .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$PaginatedBannerDataToJson(
        PaginatedBannerData instance) =>
    <String, dynamic>{
      'items': instance.items,
      'pageNumber': instance.pageNumber,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };

BannerItem _$BannerItemFromJson(Map<String, dynamic> json) => BannerItem(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String,
      status: json['status'] as String,
      isFeatured: json['isFeatured'] as bool,
      created: json['created'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$BannerItemToJson(BannerItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'isFeatured': instance.isFeatured,
      'created': instance.created,
      'createdBy': instance.createdBy,
    };
