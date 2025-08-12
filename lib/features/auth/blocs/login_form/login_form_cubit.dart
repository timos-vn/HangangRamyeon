import 'package:formz/formz.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/value_objects/phone.dart';

import '../../../../core/value_objects/password.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginState> {
  LoginFormCubit() : super(const LoginState());

  void changeObscurity() {
    emit(state.copyWith(
      isObscure: !state.isObscure,
      error: null,
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      isValid: Formz.validate([phone, state.password]),
      error: null,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.phone]),
      error: null,
    ));
  }

  Future<void> login() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
  }
}
