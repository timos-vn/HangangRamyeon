import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/features/voucher/blocs/voucher_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/di/dependency_injection.dart';
import 'core/router/app_router.dart';
import 'core/services/local_notifications_service.dart';
import 'core/services/push_notification_service.dart';
import 'core/services/secure_storage_service.dart';
import 'core/services/shared_prefs_service.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/const.dart';
import 'features/auth/blocs/authentication/authentication_cubit.dart';
import 'features/auth/blocs/login_form/login_form_cubit.dart';
import 'features/auth/blocs/sign_up_form/sign_up_form_cubit.dart';
import 'features/home/blocs/home_cubit.dart';
import 'features/main/blocs/main/bottom_nav_cubit.dart';
import 'features/onboarding/cubit/onboarding_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/profile/cubit/settings_cubit.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized(); // lớp kết nối giữa Flutter framework và engine.
  await Firebase.initializeApp();
  configureDependencies();
  await LocalNotificationService().init();
  await PushNotificationService().init();
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  HydratedBloc.storage = storage;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final token = await getIt<SecureStorageService>().read(CacheKeys.accessToken);
  final isLogged = getIt<CacheService>().getBool(CacheKeys.isLogged);
  // Load cached Const data on app start
  Const.loadFromCache(getIt<CacheService>());

  // Load shops data for bill printing
  if (isLogged == true) {
    try {
      final settingsCubit = getIt<SettingsCubit>();
      await settingsCubit.getShops();
    } catch (e) {
      print('Error loading shops data: $e');
    }
  }

  print(token);
  print(isLogged);

  final bool isAuthenticated = token != null && token.isNotEmpty && isLogged == true;
  final appRouter = AppRouter(isAuthenticated);
  print("appRouter");
  print(appRouter.router);
  runApp(HangangRamyonApp(router: appRouter.router,));
}

class HangangRamyonApp extends StatelessWidget {
  final GoRouter router;
  const HangangRamyonApp({super.key,required this.router});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        // For bigger apps, you should not define them globally. Since this is a small app, I'm defining them globally.
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OnboardingCubit(),
            ),
            BlocProvider(
              create: (context) => getIt<AuthenticationCubit>(),
            ),
            BlocProvider(
              create: (context) => ThemeCubit(),
            ),
            BlocProvider(
              create: (context) => LoginFormCubit(),
            ),
            BlocProvider(
              create: (context) => SignUpFormCubit(),
            ),
            BlocProvider(
              create: (context) => BottomNavCubit(),
            ),
            BlocProvider(
              create: (context) => getIt<HomeCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<VoucherCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<SettingsCubit>(),
            ),

          ],
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Hangang Ramyeon',
                themeMode: ThemeMode.light,
                theme: state,
                routerConfig: router,
              );
            },
          ),
        );
      },
    );
  }
}
