// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderResponse _$UpdateOrderResponseFromJson(Map<String, dynamic> json) =>
    UpdateOrderResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: json['data'],
    );

Map<String, dynamic> _$UpdateOrderResponseToJson(
        UpdateOrderResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data,
    };
