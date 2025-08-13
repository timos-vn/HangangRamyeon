import 'package:injectable/injectable.dart';
import 'package:hangangramyeon/core/network/api_service.dart';
import 'package:hangangramyeon/core/network/dio_client.dart';
import '../models/shop_model.dart';
import '../models/user_update_model.dart';
import '../../../auth/data/models/user_info_model.dart';
import '../../../auth/data/models/change_password_model.dart';
import '../../../auth/data/models/reset_password_model.dart';

@lazySingleton
class SettingsService {
  final ApiService _apiService;

  SettingsService(this._apiService);

  Future<ShopResponse> getShops() async {
    try {
      return await _apiService.getShops(1, 1000);
    } catch (e) {
      rethrow;
    }
  }

  Future<ShopResponse> updateShop(String shopId, Shop shop) async {
    try {
      return await _apiService.updateShop(shopId, shop);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserUpdateResponse> updateUser(String userId, UserUpdateRequest request) async {
    try {
      return await _apiService.updateUser(userId, request);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserInfoResponse> getUserInfo(String userId) async {
    try {
      return await _apiService.getUserInfo(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request) async {
    try {
      return await _apiService.changePassword(request);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) async {
    try {
      return await _apiService.resetPassword(request);
    } catch (e) {
      rethrow;
    }
  }
}
