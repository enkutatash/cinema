import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/core/network/network.dart';
import 'package:cinema/features/auth/data/data_source/local_data_source.dart';
import 'package:cinema/features/auth/data/data_source/remote_data_source.dart';
import 'package:cinema/features/auth/data/model/auth_model.dart';
import 'package:cinema/features/auth/domain/repository/auth_repo.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImp extends AuthRepo {
  RemoteDataSource remoteDataSource;
  LocalDataSource localDataSource;
  NetworkInfo networkInfo;
  AuthRepoImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, AuthModel>> login(
      String email, String password) async {
    try {
      if (await networkInfo.isConnected) {
        var token = await remoteDataSource.login(email, password);
        return token.fold((failure) async {
          return Left(failure);
        }, (user) async {
          
          await localDataSource.saveToken(user.token);
          return Right(user);
        });
      } else {
        return Left(Failure(message: "No Internet Connection"));
      }
    } catch (e) {
      return Left(Failure(message: "Error $e"));
    }
  }

  @override
  Future<Either<Failure, void>> register(
      String fullName, String email, String password) async {
    try {
      if (await networkInfo.isConnected) {
        return remoteDataSource.register(fullName, email, password);
      } else {
        return Left(Failure(message: "No Internet Connection"));
      }
    } catch (e) {
      return Left(Failure(message: "Error $e"));
    }
  }
}
