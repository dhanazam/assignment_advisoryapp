import 'package:formz/formz.dart';

enum LoginEmailFieldValidationError { invalid }

enum LoginPasswordFieldValidationError { invalid }

class LoginEmailFieldValidator
    extends FormzInput<String, LoginEmailFieldValidationError> {
  const LoginEmailFieldValidator.pure() : super.pure('');
  const LoginEmailFieldValidator.dirty([super.value = '']) : super.dirty();

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  LoginEmailFieldValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '')
        ? null
        : LoginEmailFieldValidationError.invalid;
  }
}

class LoginPasswordFieldValidator
    extends FormzInput<String, LoginPasswordFieldValidationError> {
  const LoginPasswordFieldValidator.pure() : super.pure('');

  const LoginPasswordFieldValidator.dirty([super.value = '']) : super.dirty();

  @override
  LoginPasswordFieldValidationError? validator(String? value) {
    return value?.isNotEmpty == true
        ? null
        : LoginPasswordFieldValidationError.invalid;
  }
}
