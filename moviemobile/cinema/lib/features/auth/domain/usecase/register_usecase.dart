import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/auth/domain/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';

class RegisterUsecase {
  final AuthRepo authRepo;
  RegisterUsecase({required this.authRepo});
  Future<Either<Failure,void>> execute (String fullName, String email, String password) {
    return authRepo.register(fullName, email, password);
  }
}