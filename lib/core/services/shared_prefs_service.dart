import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class CacheService {
  final SharedPreferences _sharedPreferences;
  CacheService(this._sharedPreferences);

  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> deleteAll() async {
    return await _sharedPreferences.clear();
  }
}

class CacheKeys {

  static const String isLogged = 'is_logged';
  static const String userName = 'user_name';
  static const String userId = 'user_id';
  static const String fullName = 'full_name';
  static const String email = 'email';
  static const String phoneNumber = 'phone_number';
  static const String shopId = 'shop_id';
  static const String shopName = 'shop_name';
  static const String roleId = 'role_id';
  static const String roleName = 'role_name';

  static const String accessToken = 'access_token';
}
