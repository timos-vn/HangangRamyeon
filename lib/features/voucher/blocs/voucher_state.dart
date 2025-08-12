import 'package:equatable/equatable.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_response.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_response.dart';
import 'package:hangangramyeon/features/voucher/models/voucher_model.dart';


abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object?> get props => [];
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherLoaded extends VoucherState {
  final VoucherModel voucherModel;

  const VoucherLoaded(this.voucherModel);

  @override
  List<Object?> get props => [];
}

class CheckPromotionSuccess extends VoucherState {
  final CheckPromotionModelResponse promotionModelResponse;

  const CheckPromotionSuccess(this.promotionModelResponse);

  @override
  List<Object?> get props => [];
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError(this.message);

  @override
  List<Object?> get props => [message];
}
