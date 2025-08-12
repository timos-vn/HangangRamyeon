import 'package:json_annotation/json_annotation.dart';
import '../../voucher/models/common_detail.dart';

part 'check_voucher_model_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckVoucherModelRequest {
  @JsonKey(name: 'ShopId')
  final String? shopId;

  @JsonKey(name: 'CustomerId')
  final String? customerId;

  @JsonKey(name: 'VoucherCode')
  final String voucherCode;

  @JsonKey(name: 'Details')
  final List<CommonDetail> details;

  CheckVoucherModelRequest({
    this.shopId,
    this.customerId,
    required this.voucherCode,
    required this.details,
  });

  factory CheckVoucherModelRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckVoucherModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckVoucherModelRequestToJson(this);
}
