import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/data/models/auth_response_model.dart';
import '../../features/auth/data/models/change_password_model.dart';
import '../../features/auth/data/models/reset_password_model.dart';
import '../../features/auth/data/models/user_info_model.dart';
import '../../features/profile/data/models/shop_model.dart';
import '../../features/profile/data/models/user_update_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/auth/refresh-token")
  Future<AuthResponseModel> refreshToken(
    @Header('Authorization') String refreshToken,
  );

  @GET("/api/shops")
  Future<ShopResponse> getShops(
    @Query('pageNumber') int pageNumber,
    @Query('pageSize') int pageSize,
  );

  @PUT("/api/shops/{shopId}")
  Future<ShopResponse> updateShop(
    @Path('shopId') String shopId,
    @Body() Shop shop,
  );

  @PUT("/api/users/{userId}")
  Future<UserUpdateResponse> updateUser(
    @Path('userId') String userId,
    @Body() UserUpdateRequest userUpdateRequest,
  );

  @GET("/api/users/{userId}")
  Future<UserInfoResponse> getUserInfo(
    @Path('userId') String userId,
  );

  @POST("/api/auth/change-password")
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordRequest request,
  );

  @POST("/api/auth/reset-password")
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
