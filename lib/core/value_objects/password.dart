import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty(super.value) : super.dirty();

  static final _uppercaseRegex = RegExp(r'[A-Z]');
  static final _specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
  static final _digitRegex = RegExp(r'\d');

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < 6 ||
        !_uppercaseRegex.hasMatch(value) ||
        !_specialCharRegex.hasMatch(value) ||
        !_digitRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}

