import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/auth/domain/entity/auth_entity.dart';
import 'package:cinema/features/auth/domain/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepo authRepo;

  LoginUsecase({required this.authRepo});
  Future<Either<Failure,AuthEntity>> execute (String email, String password) {
    return authRepo.login(email, password);
  }
}
