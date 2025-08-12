import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hangangramyeon/core/errors/failure.dart';
import 'package:hangangramyeon/core/network/dio_exception.dart';
import 'package:hangangramyeon/features/home/data_sources/home_remote_data_source.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_request.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_request.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_response.dart';
import 'package:hangangramyeon/features/home/models/customer_info_model_response.dart';
import 'package:hangangramyeon/features/home/models/production_detail_model.dart';
import 'package:hangangramyeon/features/home/models/request/create_order_request.dart';
import 'package:hangangramyeon/features/home/models/request/update_order_request.dart';
import 'package:hangangramyeon/features/home/models/response/create_order_response.dart';
import 'package:hangangramyeon/features/home/models/response/detail_transaction_response.dart';
import 'package:hangangramyeon/features/home/models/response/production_response.dart';
import 'package:hangangramyeon/features/home/models/response/setting_response.dart';
import 'package:hangangramyeon/features/home/models/response/transaction_response.dart';
import 'package:hangangramyeon/features/home/models/response/update_order_response.dart';
import 'package:hangangramyeon/features/home/models/user_model.dart';
import 'package:injectable/injectable.dart';

import '../models/add_promotion_to_order_model_response.dart';

abstract class IHomeRepository {
  Future<Either<Failure, UserModel>> getUserInformation(String idUser);
  Future<Either<Failure, BannerAndPostModel>> getBanner(int pageIndex, int pageCount);
  Future<Either<Failure, ProductionDetailModel>> scanBarcode(String barcode);
  Future<Either<Failure, CheckVoucherModelResponse>> checkVoucher(CheckVoucherModelRequest request);
  Future<Either<Failure, AddPromotionToOrderModelResponse>> addPromotionToOrder(AddPromotionToOrderModelRequest request);
  Future<Either<Failure, CreateOrderResponse>> createOrder(CreateOrderRequest request);
  Future<Either<Failure, UpdateOrderResponse>> updateOrder(String idOrder,UpdateOrderRequest request);
  Future<Either<Failure, CustomerInfoModelResponse>> searchCustomer(String search);
  Future<Either<Failure, TransactionResponse>> getListTransaction(int indexPage);
  Future<Either<Failure, ProductionResponse>> getListProduction(int indexPage, String search);
  Future<Either<Failure, DetailTransactionResponse>> getDetailTransaction(String idTransaction);
  Future<Either<Failure, TransactionResponse>> getListTransactionIsManager(int indexPage);
  Future<Either<Failure, SettingResponse>> getSetting();
}

@LazySingleton(as: IHomeRepository)
class HomeRepository implements IHomeRepository {
  final IHomeRemoteDataSource _homeRemoteDataSource;

  HomeRepository(this._homeRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getUserInformation(String idUser) async {
    try {
      final response = await _homeRemoteDataSource.getUserInformation(idUser);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, BannerAndPostModel>> getBanner(int pageIndex, int pageCount) async {
    try {
      final response = await _homeRemoteDataSource.getBanner(pageIndex,pageCount);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductionDetailModel>> scanBarcode(String barcode) async {
    try {
      final response = await _homeRemoteDataSource.scanBarcode(barcode,20,1);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
  @override
  Future<Either<Failure, CheckVoucherModelResponse>> checkVoucher(CheckVoucherModelRequest request) async {
    try {
      final response = await _homeRemoteDataSource.checkVoucherCode(request);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message)); //DISCOUNT80
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, AddPromotionToOrderModelResponse>> addPromotionToOrder(AddPromotionToOrderModelRequest request) async {
    try {
      final response = await _homeRemoteDataSource.addPromotionToOrder(request);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CreateOrderResponse>> createOrder(CreateOrderRequest request) async {
    try {
      final response = await _homeRemoteDataSource.createOrder(request);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UpdateOrderResponse>> updateOrder(String idOrder, UpdateOrderRequest request) async {
    try {
      final response = await _homeRemoteDataSource.updateOrder(idOrder,request);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, CustomerInfoModelResponse>> searchCustomer(String search) async {
    try {
      final response = await _homeRemoteDataSource.searchCustomer(1,500,search);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> getListTransaction(int pageNumber) async {
    try {
      final response = await _homeRemoteDataSource.getListTransaction(pageNumber,10);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, DetailTransactionResponse>> getDetailTransaction(String idTransaction) async {
    try {
      final response = await _homeRemoteDataSource.getDetailTransaction(idTransaction);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, TransactionResponse>> getListTransactionIsManager(int pageNumber) async {
    try {
      final response = await _homeRemoteDataSource.getListTransactionIsManager(pageNumber,10,'-');
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ProductionResponse>> getListProduction(int pageNumber,String search) async {
    try {
      final response = await _homeRemoteDataSource.getListProduction(pageNumber,10,search);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, SettingResponse>> getSetting() async {
    try {
      final response = await _homeRemoteDataSource.getSetting();
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }
  // @override
  // Future<Either<Failure, bool>> updateTask(TaskModel task) async {
  //   try {
  //     await _taskRemoteDataSource.updateTask(
  //       task.id ?? '',
  //       task,
  //     );
  //     return right(true);
  //   } on DioException catch (e) {
  //     debugPrint('DioException: $e');
  //     final errorMessage = DioExceptions.fromDioError(e);
  //     return left(ServerFailure(errorMessage: errorMessage.message));
  //   } catch (e) {
  //     return left(ServerFailure(errorMessage: "Something went wrong"));
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, void>> deleteTask(String id) async {
  //   try {
  //     await _taskRemoteDataSource.deleteTask(id);
  //     return right(null);
  //   } on DioException catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e);
  //     return left(ServerFailure(errorMessage: errorMessage.message));
  //   } catch (e) {
  //     return left(ServerFailure(errorMessage: "Something went wrong"));
  //   }
  // }
}
