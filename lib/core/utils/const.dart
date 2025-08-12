import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
class Const {
  static String shopId = "";
  static String userId = "";
  static String userName = '';
  static String level = '';
  static int point = 0;
  static bool isManager = false;
  static int pointValue = 1;

  // Load/save helpers
  static void loadFromCache(CacheService cache) {
    userId = cache.getString(CacheKeys.userId);
    userName = cache.getString(CacheKeys.userName);
    level = cache.getString(CacheKeys.level);
    point = cache.getInt(CacheKeys.point);
    isManager = cache.getBool(CacheKeys.isManager);
    shopId = cache.getString(CacheKeys.shopId);
    pointValue = cache.getInt(CacheKeys.pointValue);
  }

  static Future<void> saveToCache(CacheService cache) async {
    await cache.setString(CacheKeys.userId, userId);
    await cache.setString(CacheKeys.userName, userName);
    await cache.setString(CacheKeys.level, level);
    await cache.setInt(CacheKeys.point, point);
    await cache.setBool(CacheKeys.isManager, isManager);
    await cache.setString(CacheKeys.shopId, shopId);
    await cache.setInt(CacheKeys.pointValue, pointValue);
  }
}