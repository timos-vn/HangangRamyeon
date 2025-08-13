import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../data/services/settings_service.dart';
import '../data/models/shop_model.dart';
import '../data/models/user_update_model.dart';
import '../../auth/data/models/user_info_model.dart';
import '../../auth/data/models/change_password_model.dart';
import '../../auth/data/models/reset_password_model.dart';

part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService _settingsService;

  SettingsCubit(this._settingsService) : super(SettingsInitial());

  Future<void> getShops() async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.getShops();
      if (response.succeeded) {
        emit(ShopsLoaded(response.data.items));
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> updateShop(String shopId, Shop shop) async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.updateShop(shopId, shop);
      if (response.succeeded) {
        emit(ShopUpdated());
        // Refresh shops after update
        await getShops();
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> updateUser(String userId, UserUpdateRequest request) async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.updateUser(userId, request);
      if (response.succeeded) {
        emit(UserUpdated());
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> getUserInfo(String userId) async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.getUserInfo(userId);
      if (response.succeeded && response.data != null) {
        emit(UserInfoLoaded(response.data!));
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.changePassword(request);
      if (response.succeeded) {
        emit(PasswordChanged());
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(SettingsLoading());
    try {
      final response = await _settingsService.resetPassword(request);
      if (response.succeeded) {
        emit(PasswordReset());
      } else {
        emit(SettingsError(response.errors.join(', ')));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
