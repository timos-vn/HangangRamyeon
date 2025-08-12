import 'package:json_annotation/json_annotation.dart';
import 'common_detail.dart';

part 'check_promotion_model_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckPromotionModelRequest {
  final String? shopId;
  final String? customerId;
  final List<CommonDetail> details;

  CheckPromotionModelRequest({
    this.shopId,
    this.customerId,
    required this.details,
  });

  factory CheckPromotionModelRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckPromotionModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPromotionModelRequestToJson(this);
}
