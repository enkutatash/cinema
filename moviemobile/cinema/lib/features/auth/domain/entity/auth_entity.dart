import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String fullName;
  final String email;
  final String role;
  final String uid;
  final String token;
  AuthEntity({
    required this.fullName,
    required this.email,
    required this.role,
    required this.uid,
    required this.token,

  });

  @override
  List<Object?> get props => [fullName, email, role, uid, token];
}
