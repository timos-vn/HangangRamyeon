part of 'login_form_cubit.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isObscure = true,
    this.error,
  });

  final FormzSubmissionStatus status;
  final Phone phone;
  final Password password;
  final bool isValid;
  final bool isObscure;
  final String? error;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Phone? phone,
    Password? password,
    bool? isValid,
    bool? isObscure,
    String? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isObscure: isObscure ?? this.isObscure,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        phone,
        password,
        isValid,
        isObscure,
        error,
      ];
}
