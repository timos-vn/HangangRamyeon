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

  Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  String getString(String key) {
    return _sharedPreferences.getString(key) ?? '';
  }

  Future<void> setInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  int getInt(String key) {
    return _sharedPreferences.getInt(key) ?? 0;
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

  // App preferences
  static const String notificationsEnabled = 'notifications_enabled';

  // Cached profile/info for Const
  static const String level = 'level';
  static const String point = 'point';
  static const String isManager = 'is_manager';
  static const String pointValue = 'point_value';

  // Printer and payment settings
  static const String printerIp = 'printer_ip';
  static const String bankAccountName = 'bank_account_name';
  static const String bankAccountNumber = 'bank_account_number';
  static const String bankName = 'bank_name';
}
