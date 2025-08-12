import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hangangramyeon/core/value_objects/birthday.dart';
import 'package:hangangramyeon/core/value_objects/phone.dart';

import '../../../../core/value_objects/email.dart';
import '../../../../core/value_objects/password.dart';
import '../../../../core/value_objects/username.dart';
part 'sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpState> {
  SignUpFormCubit() : super(const SignUpState());

  void changePasswordObscurity() {
    emit(state.copyWith(
      isPasswordObscure: !state.isPasswordObscure,
      error: null,
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([
        username,
        state.phone,
        state.birthday,
        state.password,
      ]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      isValid: Formz.validate([phone, state.password,state.birthday,state.username,]),
      error: null,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password,state.birthday,state.phone,state.username,]),
      error: null,
    ));
  }


  void birthdayChanged(String value) {
    final birthday = Birthday.dirty(value);
    emit(state.copyWith(
      birthday: birthday,
      isValid: Formz.validate([birthday, state.phone,
        state.password,
        state.username,]),
      error: null,
    ));
  }

  Future<void> signup() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
  }
}
