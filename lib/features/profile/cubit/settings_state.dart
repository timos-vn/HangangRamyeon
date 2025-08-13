part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class ShopsLoaded extends SettingsState {
  final List<Shop> shops;

  const ShopsLoaded(this.shops);

  @override
  List<Object?> get props => [shops];
}

class ShopUpdated extends SettingsState {}

class UserUpdated extends SettingsState {}

class UserInfoLoaded extends SettingsState {
  final UserInfoData userInfo;

  const UserInfoLoaded(this.userInfo);

  @override
  List<Object?> get props => [userInfo];
}

class PasswordChanged extends SettingsState {}

class PasswordReset extends SettingsState {}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
