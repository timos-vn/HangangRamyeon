import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import '../services/secure_storage_service.dart';
import '../di/dependency_injection.dart';
import '../services/shared_prefs_service.dart';
import 'log.dart';

class DioClient {

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      baseUrl: Platform.isAndroid
          ? 'https://hangangramyeon.vn'
          : 'https://hangangramyeon.vn',
      contentType: 'application/json',
      validateStatus: (status) {
        return status != null && status < 400; // Cho phép 3xx
      },
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
        onResponse:  (Response response, handler) {
          // Do something with response data
          logger.d(
              "<-- ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > 200) {
            int iterations =
            (responseAsString.length / 200).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * 200 + 200;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              print(responseAsString.substring(
                  i * 200, endingIndex));
            }
          } else {
            logger.d(response.data);
          }
          logger.d("<-- END HTTP");
          return handler.next(response); // continue
        }
      ),
    );

  static Dio get instance => _dio;

  static Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('📤 REQUEST [${options.method}]');
    debugPrint('➡️ URL: ${options.baseUrl}${options.path}');

    if (options.queryParameters.isNotEmpty) {
      debugPrint('🔍 Query Parameters: ${jsonEncode(options.queryParameters)}');
    }

    if (options.data != null) {
      debugPrint('📦 Body Data: ${jsonEncode(options.data)}');
    }
    if (!_isAuthRoute(options.path)) {
      final token = await _getValidToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  static Future<String?> _getValidToken() async {
    final storage = getIt<SecureStorageService>();
    final token = await storage.read(CacheKeys.accessToken);

    if (token != null && token.isNotEmpty) {
      return token;
    }

    return null;
  }

  static Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('ERROR[${err.response?.statusCode}] => ${err.message}');

    if (err.response?.statusCode == 401) {
      await _logout();
    }

    handler.next(err);
  }

  static bool _isAuthRoute(String path) {
    return path.contains('auth/login') || path.contains('api/users/createCustomer');
  }

  static Future<void> _logout() async {
    debugPrint(
        'Logging out due to authentication failure. here is the full login endpoint: ${_dio.options.baseUrl}/auth/login');
    await getIt<SecureStorageService>().deleteAll();
    getIt<CacheService>().setBool(CacheKeys.isLogged, false);

    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.goNamed(RouteNames.loginpage);
    }
  }
}
