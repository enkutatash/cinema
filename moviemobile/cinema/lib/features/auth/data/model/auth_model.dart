import 'package:cinema/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel(
      {required super.fullName, required super.email,required super.role,required super.uid,required super.token});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'role': role,
      'uid': uid,
      'token': token,

    };
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
      uid: json['userID'],
      token: json['token'],
    );
  }

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      fullName: entity.fullName,
      email: entity.email,
      role: entity.role,
      uid: entity.uid,
      token: entity.token,
      
    );
  }
}
