import 'package:json_annotation/json_annotation.dart';

part 'setting_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingResponse {
  final bool succeeded;
  final List<String> errors;
  final SettingData? data;

  SettingResponse({
    required this.succeeded,
    required this.errors,
    this.data,
  });

  factory SettingResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SettingData {
  final bool succeeded;
  final List<String> errors;
  final List<SettingItem> data;

  SettingData({
    required this.succeeded,
    required this.errors,
    required this.data,
  });

  factory SettingData.fromJson(Map<String, dynamic> json) =>
      _$SettingDataFromJson(json);

  Map<String, dynamic> toJson() => _$SettingDataToJson(this);
}

@JsonSerializable()
class SettingItem {
  final String key;
  final String value;

  SettingItem({
    required this.key,
    required this.value,
  });

  factory SettingItem.fromJson(Map<String, dynamic> json) =>
      _$SettingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SettingItemToJson(this);
}
