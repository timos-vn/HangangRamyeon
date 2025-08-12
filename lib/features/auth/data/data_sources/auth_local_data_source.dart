import 'package:hangangramyeon/features/auth/data/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/shared_prefs_service.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveIsLogged();
  Future<void> saveInfoAccount(AuthData authData);
  Future<void> deleteTokens();
}

@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  final SecureStorageService _secureStorageService;
  final CacheService _cacheService;

  AuthLocalDataSource(
    this._secureStorageService,
    this._cacheService,
  );

  @override
  Future<void> saveIsLogged() async {
    try {
      await _cacheService.setBool(CacheKeys.isLogged, true);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTokens() async {
    try {
      await _secureStorageService.deleteAll();

      await _cacheService.setBool(CacheKeys.isLogged, false);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> saveInfoAccount(AuthData authData)async {
    try {
      await _secureStorageService.deleteAll();
      await _secureStorageService.write(CacheKeys.accessToken, authData.accessToken.toString());
      await _secureStorageService.write(CacheKeys.userName, authData.user.userName.toString());
      await _secureStorageService.write(CacheKeys.userId, authData.user.id.toString());
      await _secureStorageService.write(CacheKeys.email, authData.user.email.toString());
      await _secureStorageService.write(CacheKeys.phoneNumber, authData.user.phoneNumber.toString());
      // await _secureStorageService.write(CacheKeys.shopId, authData.shop.isNotEmpty ? authData.toString() : '');
      // await _secureStorageService.write(CacheKeys.shopName, authData.shop.isNotEmpty ? authData.shop[0].shopName.toString() : '');
      await _secureStorageService.write(CacheKeys.roleId, authData.roles.isNotEmpty ? authData.roles[0].roleId.toString() : '');
      await _secureStorageService.write(CacheKeys.roleName, authData.roles.isNotEmpty ? authData.roles[0].roleName.toString() : '');
    } catch (_) {
      rethrow;
    }
  }
}
