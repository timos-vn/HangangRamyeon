import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/features/voucher/blocs/voucher_state.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_request.dart';
import 'package:hangangramyeon/features/voucher/repository/voucher_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class VoucherCubit extends Cubit<VoucherState> {

  VoucherCubit(this._voucherRepository) : super(VoucherInitial());

  final IVoucherRepository _voucherRepository;

  Future<void> getVoucherList() async {
    emit(VoucherLoading());
    final result = await _voucherRepository.getVoucher();
    result.fold(
          (failure) => emit(VoucherError(failure.errorMessage)),
          (voucherModel) {emit(VoucherLoaded(voucherModel));
      },
    );
  }

  Future<void> checkPromotion(CheckPromotionModelRequest request) async {
    emit(VoucherLoading());
    final result = await _voucherRepository.checkPromotion(request);
    result.fold(
          (failure) => emit(VoucherError(failure.errorMessage)),
          (promotionModel) {emit(CheckPromotionSuccess(promotionModel));
      },
    );
  }
}
