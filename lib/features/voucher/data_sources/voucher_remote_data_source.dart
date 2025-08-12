import 'package:dio/dio.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_request.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_response.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_request.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_response.dart';
import 'package:hangangramyeon/features/voucher/models/voucher_model.dart';
import 'package:retrofit/retrofit.dart';

part 'voucher_remote_data_source.g.dart';

@RestApi()
abstract class IVoucherRemoteDataSource {
  factory IVoucherRemoteDataSource(Dio dio, {String baseUrl}) =
  _IVoucherRemoteDataSource;

  @GET("/api/promotions")
  Future<VoucherModel> getPromotions();

  @POST("/api/promotions/checkPromotion")
  Future<CheckPromotionModelResponse> checkPromotion(
      @Body() CheckPromotionModelRequest body,
      );
}
