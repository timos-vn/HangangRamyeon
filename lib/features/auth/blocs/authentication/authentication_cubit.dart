import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/services/secure_storage_service.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/features/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.repo) : super(AuthenticationInitial()){
    checkAuthentication(); // Gọi tự động khi khởi tạo
  }
  onTransition(Bloc bloc, Transition transition) {
    print(transition); // kiểm tra luồng state
  }
  Future<void> checkAuthentication() async {
    try {
      final token = await getIt.get<SecureStorageService>().read(CacheKeys.accessToken);
      final isLogged = getIt.get<CacheService>().getBool(CacheKeys.isLogged);

      if (token != null && token.isNotEmpty && isLogged == true) {
        emit(AuthenticationSuccessState());
      } else {
        emit(UnAuthenticationState());
      }
    } catch (e) {
      emit(UnAuthenticationState()); // fallback
    }
  }

  final IAuthRepository repo;

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(AuthenticationLoadingState());
    final result = await repo.login(
      phone: phone,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(failure.errorMessage)),
      (success) => emit(AuthenticationSuccessState()),
    );
  }

  Future<void> register({
    required String username,
    required String birthDay,
    required String password,
    required String phoneNumber,
    required String fullName,
  }) async {
    emit(AuthenticationLoadingState());
    final result = await repo.signup(
      username: username,
      birthDay: birthDay,
      password: password,
      phoneNumber: phoneNumber,
      fullName: fullName,
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(failure.errorMessage)),
      (success) => emit(AuthenticationSuccessState()),
    );
  }

  Future<void> signOut() async {
    emit(AuthenticationLoadingState());
    try {
      await repo.logOut();
      emit(UnAuthenticationState());
    } catch (e) {
      emit(AuthenticationErrorState(e.toString()));
    }
  }
}
