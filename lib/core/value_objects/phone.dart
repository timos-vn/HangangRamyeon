import 'package:formz/formz.dart';

enum PhoneValidationError { empty, invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty(super.value) : super.dirty();

  static final RegExp _phoneRegex = RegExp(r'(\+84|0)\d{9}$');

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) {
      return PhoneValidationError.empty;
    } else if ((!_phoneRegex.hasMatch(value))) {
      return PhoneValidationError.invalid;
    }
    return null;
  }
}
