import 'package:dio/dio.dart';
import 'package:hangangramyeon/core/errors/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_exception.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> login({
    required String phone,
    required String password,
  });
  Future<Either<Failure, bool>> signup({
    required String username,
    required String birthDay,
    required String password,
    required String phoneNumber,
    required String fullName,
  });
  Future<void> logOut();
}

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final IAuthLocalDataSource _authLocalDataSource;

  AuthRepository(
    this._authRemoteDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, bool>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _authRemoteDataSource.login(
        LoginRequestBody(
          userName: phone,
          password: password,
        ),
      );
      await _authLocalDataSource.saveInfoAccount(response.data);

      await _authLocalDataSource.saveIsLogged();

      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong $e"));
    }
  }

  @override
  Future<Either<Failure, bool>> signup({
    required String username,
    required String birthDay,
    required String password,
    required String phoneNumber,
    required String fullName,
  }) async {
    try {
      final response = await _authRemoteDataSource.signup(
        SignUpRequestBody(
          username: username,
          birthDay: birthDay,
          password: password,
          phoneNumber: phoneNumber,
          fullName: fullName,
        ),
      );
      await _authLocalDataSource.saveInfoAccount(response.data);

      await _authLocalDataSource.saveIsLogged();

      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong $e"));
    }
  }

  @override
  Future<void> logOut() async {
    try {
      // await _authRemoteDataSource.logOut();
      await _authLocalDataSource.deleteTokens();
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
