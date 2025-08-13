// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopResponse _$ShopResponseFromJson(Map<String, dynamic> json) => ShopResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: ShopData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopResponseToJson(ShopResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

ShopData _$ShopDataFromJson(Map<String, dynamic> json) => ShopData(
      items: (json['items'] as List<dynamic>)
          .map((e) => Shop.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$ShopDataToJson(ShopData instance) => <String, dynamic>{
      'items': instance.items,
      'pageNumber': instance.pageNumber,
      'totalPages': instance.totalPages,
      'totalCount': instance.totalCount,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
    };

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      taxCode: json['taxCode'] as String,
      bankName: json['bankName'] as String,
      bankNumber: json['bankNumber'] as String,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'taxCode': instance.taxCode,
      'bankName': instance.bankName,
      'bankNumber': instance.bankNumber,
    };
