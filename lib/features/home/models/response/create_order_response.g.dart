// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOrderResponse _$CreateOrderResponseFromJson(Map<String, dynamic> json) =>
    CreateOrderResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: CreateOrderData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateOrderResponseToJson(
        CreateOrderResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };

CreateOrderData _$CreateOrderDataFromJson(Map<String, dynamic> json) =>
    CreateOrderData(
      id: json['id'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$CreateOrderDataToJson(CreateOrderData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
    };
