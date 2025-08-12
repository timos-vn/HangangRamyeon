import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hangangramyeon/core/errors/failure.dart';
import 'package:hangangramyeon/core/network/dio_exception.dart';
import 'package:hangangramyeon/features/home/models/user_model.dart';
import 'package:hangangramyeon/features/voucher/data_sources/voucher_remote_data_source.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_response.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_request.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_response.dart';
import 'package:hangangramyeon/features/voucher/models/voucher_model.dart';
import 'package:injectable/injectable.dart';

import '../models/check_promotion_model_request.dart';

abstract class IVoucherRepository {
  Future<Either<Failure, VoucherModel>> getVoucher();
  Future<Either<Failure, CheckPromotionModelResponse>> checkPromotion(CheckPromotionModelRequest request);
}

@LazySingleton(as: IVoucherRepository)
class VoucherRepository implements IVoucherRepository {
  final IVoucherRemoteDataSource _voucherRemoteDataSource;

  VoucherRepository(this._voucherRemoteDataSource);

  @override
  Future<Either<Failure, VoucherModel>> getVoucher() async {
    try {
      final response = await _voucherRemoteDataSource.getPromotions();
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(
          ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }



  @override
  Future<Either<Failure, CheckPromotionModelResponse>> checkPromotion(CheckPromotionModelRequest request) async {
    try {
      final response = await _voucherRemoteDataSource.checkPromotion(request);
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      print(errorMessage);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      print(e);
      return left(ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  // @override
  // Future<Either<Failure, UserModel>> updateProfile(UserModel user) async {
  //   try {
  //     final updatedUser = await _profileRemoteDataSource.updateProfile(user);
  //
  //     return right(updatedUser);
  //   } on DioException catch (e) {
  //     final errorMessage = DioExceptions.fromDioError(e);
  //
  //     return left(ServerFailure(errorMessage: errorMessage.message));
  //   } catch (e) {
  //     return left(
  //         ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
  //   }
  // }
}
