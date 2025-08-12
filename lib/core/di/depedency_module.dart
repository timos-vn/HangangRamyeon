import 'package:dio/dio.dart';
import 'package:hangangramyeon/core/network/api_service.dart';
import 'package:hangangramyeon/features/home/data_sources/home_remote_data_source.dart';
import 'package:hangangramyeon/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:hangangramyeon/features/voucher/data_sources/voucher_remote_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../network/dio_client.dart';

@module
abstract class DepedencyModule {
  @lazySingleton
  Dio get dio => DioClient.instance;
/*
* @preResolve
*  Dùng cho các dependency bất đồng bộ (Future) – như SharedPreferences, Firebase.initializeApp()
* Bắt buộc phải được khởi tạo xong hoàn toàn trước khi app chạy
* Injectable sẽ await các dependency này trong configureDependencies() trước khi runApp()
* */

/*
* @lazySingleton
* Chỉ tạo một instance duy nhất của MyService
* Nhưng chưa tạo ngay lúc app khởi động – chỉ khi lần đầu tiên gọi thì mới tạo
* Tiết kiệm bộ nhớ nếu dependency không được dùng ngay
* */

/*
| Annotation       | Tác dụng chính                      | Dùng khi nào                        |
| ---------------- | ----------------------------------- | ----------------------------------- |
| `@lazySingleton` | Chỉ tạo 1 instance, lần đầu mới tạo | Cho service không cần async         |
| `@preResolve`    | Chờ Future hoàn tất khi khởi động   | Cho dependency bất đồng bộ (Future) |
*
* */

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  ApiService get apiService => ApiService(dio);

  @lazySingleton
  IAuthRemoteDataSource get authRemoteDataSource => IAuthRemoteDataSource(dio);

  @lazySingleton
  IHomeRemoteDataSource get homeRemoteDataSource => IHomeRemoteDataSource(dio);

  @lazySingleton
  IProfileRemoteDataSource get profileRemoteDataSource => IProfileRemoteDataSource(dio);

  @lazySingleton
  IVoucherRemoteDataSource get voucherRemoteDataSource => IVoucherRemoteDataSource(dio);
}
