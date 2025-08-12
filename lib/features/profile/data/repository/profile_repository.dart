import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hangangramyeon/core/errors/failure.dart';
import 'package:hangangramyeon/core/network/dio_exception.dart';
import 'package:hangangramyeon/features/home/models/user_model.dart';
import 'package:injectable/injectable.dart';
import '../data_sources/profile_remote_data_source.dart';

abstract class IProfileRepository {
  Future<Either<Failure, UserModel>> getProfile(String userId);
  Future<Either<Failure, UserModel>> updateProfile(UserModel user);
  Future<Either<Failure, String>> deleteAccount(String userId);
}

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepository(this._profileRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getProfile(String userId) async {
    try {
      final response = await _profileRemoteDataSource.getProfile(userId);

      // Validate response data
      // if (response. == null && response.avatarIndex == null) {
      //   return left(
      //       ServerFailure(errorMessage: "Invalid profile data received"));
      // }

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
  Future<Either<Failure, UserModel>> updateProfile(UserModel user) async {
    try {
      final updatedUser = await _profileRemoteDataSource.updateProfile(user);

      return right(updatedUser);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);

      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(
          ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAccount(String userId) async {
    try {
      await _profileRemoteDataSource.deleteAccount(userId);
      // Server returns 200 with a body, but we ignore body to avoid fromJson issues
      return right('User deleted successfully');
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(
          ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }
}
