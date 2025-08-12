import 'package:equatable/equatable.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_response.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_response.dart';
import 'package:hangangramyeon/features/home/models/customer_info_model_response.dart';
import 'package:hangangramyeon/features/home/models/production_detail_model.dart';
import 'package:hangangramyeon/features/home/models/response/create_order_response.dart';
import 'package:hangangramyeon/features/home/models/response/detail_transaction_response.dart';
import 'package:hangangramyeon/features/home/models/response/production_response.dart';
import 'package:hangangramyeon/features/home/models/response/setting_response.dart';
import 'package:hangangramyeon/features/home/models/response/transaction_response.dart';
import 'package:hangangramyeon/features/home/models/response/update_order_response.dart';
import 'package:hangangramyeon/features/home/models/user_model.dart';


abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class InfoAccountSuccess extends HomeState {
  final String userId;

  const InfoAccountSuccess({required this.userId});
}

class HomeUserSuccess extends HomeState {
  final UserModel userModel;

  const HomeUserSuccess(this.userModel);

  @override
  List<Object?> get props => [];
}

class BannerSuccess extends HomeState {
  final BannerAndPostModel bannerAndPostModel;

  const BannerSuccess(this.bannerAndPostModel);

  @override
  List<Object?> get props => [];
}
class CreateOrderSuccess extends HomeState {
  final CreateOrderResponse createOrderResponse;

  const CreateOrderSuccess(this.createOrderResponse);

  @override
  List<Object?> get props => [];
}
class UpdateOrderSuccess extends HomeState {
  final UpdateOrderResponse updateOrderResponse;

  const UpdateOrderSuccess(this.updateOrderResponse);

  @override
  List<Object?> get props => [];
}
class GetListTransactionSuccess extends HomeState {
  final TransactionResponse transactionResponse;

  const GetListTransactionSuccess(this.transactionResponse);

  @override
  List<Object?> get props => [];
}

class GetListProductionSuccess extends HomeState {
  final ProductionResponse productionResponse;

  const GetListProductionSuccess(this.productionResponse);

  @override
  List<Object?> get props => [];
}

class GetSettingSuccess extends HomeState {
  final SettingResponse settingResponse;

  const GetSettingSuccess(this.settingResponse);

  @override
  List<Object?> get props => [];
}
class GetDetailListTransactionSuccess extends HomeState {
  final DetailTransactionResponse detailTransactionResponse;

  const GetDetailListTransactionSuccess(this.detailTransactionResponse);

  @override
  List<Object?> get props => [];
}

class CheckVoucherSuccess extends HomeState {
  final CheckVoucherModelResponse voucherModelResponse;

  const CheckVoucherSuccess(this.voucherModelResponse);

  @override
  List<Object?> get props => [];
}
class AddPromotionToOrderSuccess extends HomeState {
  final AddPromotionToOrderModelResponse infoBill;

  const AddPromotionToOrderSuccess(this.infoBill);

  @override
  List<Object?> get props => [];
}
class SearchCustomerSuccess extends HomeState {
  final CustomerInfoModelResponse infoCustomer;

  const SearchCustomerSuccess(this.infoCustomer);

  @override
  List<Object?> get props => [];
}
class ScanBarcodeSuccess extends HomeState {
  final ProductionDetailModel productionDetailModel;

  const ScanBarcodeSuccess(this.productionDetailModel);

  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  // final List<TaskModel> tasks;
  //
  // const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [];
}
//
// class TaskAdded extends TaskState {
//   const TaskAdded();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class TaskUpdated extends TaskState {
//   const TaskUpdated();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class TaskDeleted extends TaskState {
//   final String id;
//
//   const TaskDeleted(this.id);
//
//   @override
//   List<Object?> get props => [id];
// }

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
