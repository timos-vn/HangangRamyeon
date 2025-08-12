import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/services/secure_storage_service.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_request.dart';
import 'package:hangangramyeon/features/home/models/request/create_order_request.dart';
import 'package:hangangramyeon/features/home/models/request/update_order_request.dart';
import 'package:hangangramyeon/features/home/repository/home_repository.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_request.dart';
import 'package:injectable/injectable.dart';
import 'home_state.dart';


@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitial());

  final IHomeRepository _homeRepository;

  Future<void> infoAccount() async {
    try {
      final userId = await getIt.get<SecureStorageService>().read(CacheKeys.userId);
      if (userId != null && userId.isNotEmpty) {
        emit(InfoAccountSuccess(userId: userId));
      } else {
        emit(const HomeError(''));
      }
    } catch (e) {
      emit(const HomeError(''));
    }
  }

  Future<void> getUserId(String userId) async {
    emit(HomeLoading());
    final result = await _homeRepository.getUserInformation(userId);
    result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (userModel) => emit(HomeUserSuccess(userModel)),
    );
  }

  Future<void> getBanner(int pageIndex, int pageCount) async {
    emit(HomeLoading());
    final result = await _homeRepository.getBanner(pageIndex,pageCount);
    result.fold(
      (failure) => emit(HomeError(failure.errorMessage)),
      (bannerResponse) => emit(BannerSuccess(bannerResponse)),
    );
  }

  Future<void> scanBarcode(String barcode) async {
    emit(HomeLoading());
    final result = await _homeRepository.scanBarcode(barcode);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (productionDetailModel) => emit(ScanBarcodeSuccess(productionDetailModel)),
    );
  }

  Future<void> checkVoucher(CheckVoucherModelRequest request) async {
    emit(HomeLoading());
    final result = await _homeRepository.checkVoucher(request);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (voucherModel) {emit(CheckVoucherSuccess(voucherModel));
      },
    );
  }

  Future<void> addPromotionToOrder(AddPromotionToOrderModelRequest request) async {
    emit(HomeLoading());
    final result = await _homeRepository.addPromotionToOrder(request);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (infoBill) {emit(AddPromotionToOrderSuccess(infoBill));
      },
    );
  }

  Future<void> searchCustomer(String search) async {
    emit(HomeLoading());
    final result = await _homeRepository.searchCustomer(search);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (infoCustomer) {emit(SearchCustomerSuccess(infoCustomer));
      },
    );
  }

  Future<void> createOrder(CreateOrderRequest request) async {
    emit(HomeLoading());
    final result = await _homeRepository.createOrder(request);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (infoBill) {emit(CreateOrderSuccess(infoBill));
      },
    );
  }

  Future<void> updateOrder(String idOrder, UpdateOrderRequest request) async {
    emit(HomeLoading());
    final result = await _homeRepository.updateOrder(idOrder,request);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (infoBill) {emit(UpdateOrderSuccess(infoBill));
      },
    );
  }

  Future<void> getListTransaction(int pageIndex) async {
    emit(HomeLoading());
    final result = await _homeRepository.getListTransaction(pageIndex);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (transaction) {emit(GetListTransactionSuccess(transaction));
      },
    );
  }

  Future<void> getDetailTransaction(String idTransaction) async {
    emit(HomeLoading());
    final result = await _homeRepository.getDetailTransaction(idTransaction);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (detail) {emit(GetDetailListTransactionSuccess(detail));
      },
    );
  }

  Future<void> getListTransactionIsManager(int pageIndex) async {
    emit(HomeLoading());
    final result = await _homeRepository.getListTransactionIsManager(pageIndex);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (transaction) {emit(GetListTransactionSuccess(transaction));
      },
    );
  }

  Future<void> getSetting() async {
    emit(HomeLoading());
    final result = await _homeRepository.getSetting();
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (setting) {emit(GetSettingSuccess(setting));
      },
    );
  }

  Future<void> getListProduction(int pageIndex,search) async {
    emit(HomeLoading());
    final result = await _homeRepository.getListProduction(pageIndex,search);
    result.fold(
          (failure) => emit(HomeError(failure.errorMessage)),
          (production) {emit(GetListProductionSuccess(production));
      },
    );
  }

// Future<void> addTask(TaskModel task) async {
  //   emit(TaskLoading());
  //   final result = await _taskRepository.addTask(task);
  //   result.fold(
  //     (failure) => emit(TaskError(failure.errorMessage)),
  //     (_) => emit(const TaskAdded()),
  //   );
  // }
  //
  // Future<void> updateTask(TaskModel task) async {
  //   emit(TaskLoading());
  //   final result = await _taskRepository.updateTask(task);
  //   result.fold(
  //     (failure) => emit(TaskError(failure.errorMessage)),
  //     (updatedTask) => emit(const TaskUpdated()),
  //   );
  // }
  //
  // Future<void> deleteTask(String id) async {
  //   final result = await _taskRepository.deleteTask(id);
  //   result.fold(
  //     (failure) => emit(TaskError(failure.errorMessage)),
  //     (_) => emit(TaskDeleted(id)),
  //   );
  // }
}
