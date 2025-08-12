// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInfoModelResponse _$CustomerInfoModelResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerInfoModelResponse(
      succeeded: json['succeeded'] as bool,
      errors:
          (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
      data: CustomerInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerInfoModelResponseToJson(
        CustomerInfoModelResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'data': instance.data.toJson(),
    };

CustomerInfoData _$CustomerInfoDataFromJson(Map<String, dynamic> json) =>
    CustomerInfoData(
      total: (json['total'] as num).toInt(),
      items: (json['items'] as List<dynamic>)
          .map((e) => CustomerItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerInfoDataToJson(CustomerInfoData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

CustomerItem _$CustomerItemFromJson(Map<String, dynamic> json) => CustomerItem(
      code: json['code'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      point: (json['point'] as num?)?.toInt(),
      pointUsed: (json['pointUsed'] as num?)?.toInt(),
      settingPointId: json['settingPointId'] as String?,
      settingPoint:
          SettingPoint.fromJson(json['settingPoint'] as Map<String, dynamic>),
      lastOrder: json['lastOrder'],
      lastOrderStatus: json['lastOrderStatus'] as bool?,
      userId: json['userId'] as String?,
      id: json['id'] as String?,
      domainEvents: json['domainEvents'] as List<dynamic>,
    );

Map<String, dynamic> _$CustomerItemToJson(CustomerItem instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'point': instance.point,
      'pointUsed': instance.pointUsed,
      'settingPointId': instance.settingPointId,
      'settingPoint': instance.settingPoint.toJson(),
      'lastOrder': instance.lastOrder,
      'lastOrderStatus': instance.lastOrderStatus,
      'userId': instance.userId,
      'id': instance.id,
      'domainEvents': instance.domainEvents,
    };

SettingPoint _$SettingPointFromJson(Map<String, dynamic> json) => SettingPoint(
      name: json['name'] as String?,
      startValue: (json['startValue'] as num?)?.toDouble(),
      endValue: (json['endValue'] as num?)?.toDouble(),
      description: json['description'] as String?,
      id: json['id'] as String?,
      domainEvents: json['domainEvents'] as List<dynamic>,
    );

Map<String, dynamic> _$SettingPointToJson(SettingPoint instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startValue': instance.startValue,
      'endValue': instance.endValue,
      'description': instance.description,
      'id': instance.id,
      'domainEvents': instance.domainEvents,
    };
