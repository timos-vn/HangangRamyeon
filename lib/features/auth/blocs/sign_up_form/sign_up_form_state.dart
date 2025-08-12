part of 'sign_up_form_cubit.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.birthday = const Birthday.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isPasswordObscure = true,
    this.error,
  });

  final FormzSubmissionStatus status;
  final Phone phone;
  final Birthday birthday;
  final Password password;
  final Username username;
  final bool isValid;
  final bool isPasswordObscure;
  final String? error;

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Phone? phone,
    Birthday? birthday,
    Email? email,
    Password? password,
    Username? username,
    bool? isValid,
    bool? isPasswordObscure,
    String? error,
  }) {
    return SignUpState(
      status: status ?? this.status,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      password: password ?? this.password,
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        phone,
        birthday,
        password,
        username,
        isValid,
        isPasswordObscure,
        error,
      ];
}
