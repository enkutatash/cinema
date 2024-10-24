import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

enum PasswordValidationError { invalid }

enum ConfirmPasswordValidationError { invalid }

enum NameValidatorError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.contains('@') ? null : EmailValidationError.invalid;
  }
}

class Password extends FormzInput<String,PasswordValidationError>{
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator (String value){
    return value.length >3 ? null : PasswordValidationError.invalid;
  }
}


class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
    final String password;
  const ConfirmPassword.pure(this.password) : super.pure('');
  const ConfirmPassword.dirty(this.password,[String value = '']) : super.dirty(value);

 @override
  ConfirmPasswordValidationError? validator(String value){
    return value == password ? null : ConfirmPasswordValidationError.invalid;
  }
}

class Name extends FormzInput<String,PasswordValidationError>{
  const Name.pure() : super.pure('');
  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator (String value){
    return value.length >3 ? null : PasswordValidationError.invalid;
  }
}