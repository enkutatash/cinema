part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failed }

enum FormzStatus { pure, valid, invalid }

class AuthState extends Equatable {
  final AuthStatus status;
  final String message;
  final FormzStatus formzStatus;
  AuthState(
      {this.status = AuthStatus.initial, this.formzStatus = FormzStatus.pure, this.message = ''});
  AuthState copyWith({AuthStatus? status, FormzStatus? formzStatus, String? message}) {
    return AuthState(
        message: message ?? this.message,
        status: status ?? this.status,
        formzStatus: formzStatus ?? this.formzStatus);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, formzStatus];
}
