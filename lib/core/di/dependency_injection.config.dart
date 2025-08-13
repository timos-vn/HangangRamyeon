// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hangangramyeon/core/di/depedency_module.dart' as _i54;
import 'package:hangangramyeon/core/network/api_service.dart' as _i1069;
import 'package:hangangramyeon/core/services/secure_storage_service.dart'
    as _i319;
import 'package:hangangramyeon/core/services/shared_prefs_service.dart'
    as _i574;
import 'package:hangangramyeon/core/theme/theme_cubit.dart' as _i334;
import 'package:hangangramyeon/features/auth/blocs/authentication/authentication_cubit.dart'
    as _i643;
import 'package:hangangramyeon/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i996;
import 'package:hangangramyeon/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i10;
import 'package:hangangramyeon/features/auth/data/repository/auth_repository.dart'
    as _i180;
import 'package:hangangramyeon/features/home/blocs/home_cubit.dart' as _i1060;
import 'package:hangangramyeon/features/home/data_sources/home_remote_data_source.dart'
    as _i289;
import 'package:hangangramyeon/features/home/repository/home_repository.dart'
    as _i968;
import 'package:hangangramyeon/features/profile/cubit/profile_cubit.dart'
    as _i153;
import 'package:hangangramyeon/features/profile/cubit/settings_cubit.dart'
    as _i105;
import 'package:hangangramyeon/features/profile/data/data_sources/profile_remote_data_source.dart'
    as _i96;
import 'package:hangangramyeon/features/profile/data/repository/profile_repository.dart'
    as _i580;
import 'package:hangangramyeon/features/profile/data/services/settings_service.dart'
    as _i22;
import 'package:hangangramyeon/features/voucher/blocs/voucher_cubit.dart'
    as _i944;
import 'package:hangangramyeon/features/voucher/data_sources/voucher_remote_data_source.dart'
    as _i250;
import 'package:hangangramyeon/features/voucher/repository/voucher_repository.dart'
    as _i591;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final depedencyModule = _$DepedencyModule();
    gh.factory<_i334.ThemeCubit>(() => _i334.ThemeCubit());
    gh.lazySingleton<_i361.Dio>(() => depedencyModule.dio);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => depedencyModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i1069.ApiService>(() => depedencyModule.apiService);
    gh.lazySingleton<_i10.IAuthRemoteDataSource>(
        () => depedencyModule.authRemoteDataSource);
    gh.lazySingleton<_i289.IHomeRemoteDataSource>(
        () => depedencyModule.homeRemoteDataSource);
    gh.lazySingleton<_i96.IProfileRemoteDataSource>(
        () => depedencyModule.profileRemoteDataSource);
    gh.lazySingleton<_i250.IVoucherRemoteDataSource>(
        () => depedencyModule.voucherRemoteDataSource);
    gh.lazySingleton<_i319.SecureStorageService>(
        () => const _i319.SecureStorageService());
    gh.lazySingleton<_i580.IProfileRepository>(
        () => _i580.ProfileRepository(gh<_i96.IProfileRemoteDataSource>()));
    gh.lazySingleton<_i574.CacheService>(
        () => _i574.CacheService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i968.IHomeRepository>(
        () => _i968.HomeRepository(gh<_i289.IHomeRemoteDataSource>()));
    gh.lazySingleton<_i996.IAuthLocalDataSource>(
        () => _i996.AuthLocalDataSource(
              gh<_i319.SecureStorageService>(),
              gh<_i574.CacheService>(),
            ));
    gh.lazySingleton<_i22.SettingsService>(
        () => _i22.SettingsService(gh<_i1069.ApiService>()));
    gh.lazySingleton<_i591.IVoucherRepository>(
        () => _i591.VoucherRepository(gh<_i250.IVoucherRemoteDataSource>()));
    gh.factory<_i944.VoucherCubit>(
        () => _i944.VoucherCubit(gh<_i591.IVoucherRepository>()));
    gh.factory<_i153.ProfileCubit>(
        () => _i153.ProfileCubit(gh<_i580.IProfileRepository>()));
    gh.factory<_i1060.HomeCubit>(
        () => _i1060.HomeCubit(gh<_i968.IHomeRepository>()));
    gh.lazySingleton<_i180.IAuthRepository>(() => _i180.AuthRepository(
          gh<_i10.IAuthRemoteDataSource>(),
          gh<_i996.IAuthLocalDataSource>(),
        ));
    gh.factory<_i105.SettingsCubit>(
        () => _i105.SettingsCubit(gh<_i22.SettingsService>()));
    gh.factory<_i643.AuthenticationCubit>(
        () => _i643.AuthenticationCubit(gh<_i180.IAuthRepository>()));
    return this;
  }
}

class _$DepedencyModule extends _i54.DepedencyModule {}
