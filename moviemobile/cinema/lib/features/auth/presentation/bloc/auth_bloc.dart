import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/core/form_validation/form_validation.dart';
import 'package:cinema/features/auth/domain/usecase/login_usecase.dart';
import 'package:cinema/features/auth/domain/usecase/register_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  RegisterUsecase registerUsecase;
  LoginUsecase loginUsecase;
  AuthBloc({required this.registerUsecase, required this.loginUsecase})
      : super(AuthState()) {
    on<RegisterEvent>(_register);
    on<LoginEvent>(_login);
  }

  FutureOr<void> _register(RegisterEvent event, Emitter<AuthState> emit) async {

    emit(state.copyWith(status: AuthStatus.loading));
    final name = Name.dirty(event.fullName);
    final email = Email.dirty(event.email);
    final password = Password.dirty(event.password);
    final confirmPassword =
        ConfirmPassword.dirty(event.password, event.confirmPassword);
    if (name.isValid &&
        email.isValid &&
        password.isValid &&
        confirmPassword.isValid) {
      await registerUsecase
          .execute(event.fullName, event.email, event.password)
          .then((value) {
        value.fold((failure) {

          emit(state.copyWith(status: AuthStatus.failed,message: failure.message));
        }, (voidValue) async {
          await loginUsecase.execute(event.email, event.password).then((value) {
            value.fold((failure) {
            
              emit(state.copyWith(status: AuthStatus.failed,message: failure.message));
            }, (authEntity) {
              emit(state.copyWith(
                  status: AuthStatus.success, formzStatus: FormzStatus.valid));
            });
          });
        });
      });
    } else {
      emit(state.copyWith(
        status: AuthStatus.failed,
        message: 'Invalid email or password',
      ));
    }
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));
    final email = Email.dirty(event.email);
    final password = Password.dirty(event.password);
    if (email.isValid && password.isValid) {
      loginUsecase.execute(event.email, event.password).then((value) {
        value.fold((failure) {
          emit(state.copyWith(status: AuthStatus.failed,message: failure.message));
        }, (authEntity) {
         
          emit(state.copyWith(
              status: AuthStatus.success, formzStatus: FormzStatus.valid));
        });
      });
    } else {
      emit(state.copyWith(
        status: AuthStatus.failed,message: 'Invalid email or password',
      ));
    }
  }
}
