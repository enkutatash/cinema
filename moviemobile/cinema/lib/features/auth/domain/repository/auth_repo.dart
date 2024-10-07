import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure,AuthEntity>> login(String email, String password);
  Future<Either<Failure,void>> register(String fullName, String email, String password);
}