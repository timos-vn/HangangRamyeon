import 'package:dio/dio.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_request.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_response.dart';
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

import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'home_remote_data_source.g.dart';

@RestApi()
abstract class IHomeRemoteDataSource {
  factory IHomeRemoteDataSource(Dio dio, {String baseUrl}) =
  _IHomeRemoteDataSource;

  @GET("/api/users/{id}")
  Future<UserModel> getUserInformation(
      @Path('id') String id,
      );

  @GET("/api/posts/")
  Future<BannerAndPostModel> getBanner(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      );

  @GET("/api/products/{SearchString}")
  Future<ProductionDetailModel> scanBarcode(
      @Path('SearchString') String barcode,
      @Query('pageSize') int pageSize,
      @Query('pageNumber') int pageNumber,
      );

  @POST("/api/promotions/checkVoucherCode")
  Future<CheckVoucherModelResponse> checkVoucherCode(
      @Body() CheckVoucherModelRequest body,
      );

  @POST("/api/promotions/addToOrder")
  Future<AddPromotionToOrderModelResponse> addPromotionToOrder(
      @Body() AddPromotionToOrderModelRequest body,
      );

  @POST("/api/sale-orders")
  Future<CreateOrderResponse> createOrder(
      @Body() CreateOrderRequest body,
      );

  @PUT("/api/sale-orders/{id}")
  Future<UpdateOrderResponse> updateOrder(
      @Path('id') String id,
      @Body() UpdateOrderRequest body,
      );

  @GET("/api/customers/")
  Future<CustomerInfoModelResponse> searchCustomer(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      @Query('search') String search,
      );

  @GET("/api/sale-orders/historyCustomer/")
  Future<TransactionResponse> getListTransaction(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      );

  @GET("/api/sale-orders/{id}")
  Future<DetailTransactionResponse> getDetailTransaction(
      @Path('id') String id,
      );

  @GET("/api/sale-orders/")
  Future<TransactionResponse> getListTransactionIsManager(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      @Query('productIds') String productIds,
      );

  @GET("/api/products/")
  Future<ProductionResponse> getListProduction(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      @Query('SearchString') String searchString,
      );

  @GET("/api/settings/")
  Future<SettingResponse> getSetting();
}
