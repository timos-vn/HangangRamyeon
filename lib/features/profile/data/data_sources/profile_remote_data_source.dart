import 'package:dio/dio.dart';
import 'package:hangangramyeon/features/home/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_remote_data_source.g.dart';

@RestApi()
abstract class IProfileRemoteDataSource {
  factory IProfileRemoteDataSource(Dio dio, {String baseUrl}) =
      _IProfileRemoteDataSource;

  @GET("/api/users/{id}")
  Future<UserModel> getProfile(@Path('id') String id);

  @PUT("/me")
  Future<UserModel> updateProfile(
    @Body() UserModel user,
  );

  @DELETE("/api/users/{id}")
  Future<void> deleteAccount(@Path('id') String id);
}
