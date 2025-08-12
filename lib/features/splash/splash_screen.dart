import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hangangramyeon/core/constants/app_assets.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/services/secure_storage_service.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:icons_plus/icons_plus.dart';

class SPlashScreen extends StatefulWidget {
  const SPlashScreen({super.key});

  @override
  State<SPlashScreen> createState() => _SPlashScreenState();
}

class _SPlashScreenState extends State<SPlashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _startDelay();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 3), () async {
      final token = await getIt.get<SecureStorageService>().read(CacheKeys.accessToken);
      final isLogged = getIt.get<CacheService>().getBool(CacheKeys.isLogged);

      // final onBoardDone = getIt.get<CacheService>().getBool(CacheKeys.onBoardingDone);

      if (isLogged && token != null && token.isNotEmpty) {
        if (mounted) context.go(RouteNames.loginpage);
      } else {
        if (mounted) context.go(RouteNames.loginpage);
        // if (onBoardDone) {
          // if (mounted) context.go(RouteNames.welcomepage);
        // } else {
          // if (mounted) context.go(RouteNames.onboarding);
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: Center(
        child:
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.contain,
            ),
        ),
      ),
    );
  }
}
