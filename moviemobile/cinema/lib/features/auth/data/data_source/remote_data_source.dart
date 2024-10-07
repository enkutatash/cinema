import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/auth/data/model/auth_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, AuthModel>> login(String email, String password);
  Future<Either<Failure, void>> register(
      String fullName, String email, String password);
}

class RemoteDataSourceImp extends RemoteDataSource {
  Dio dio;
  RemoteDataSourceImp({required this.dio});
  @override
  Future<Either<Failure, AuthModel>> login(
      String email, String password) async {
    try {
      final user = {"email": email, "password": password};
      final response =
          await dio.post("http://192.168.98.27:8080/login", data: user);
      if (response.statusCode == 200) {
        final responseData = response.data;
        print("login remote" + responseData.toString());
        final user = AuthModel.fromJson(responseData);
        return Right(user);
      }

      return Left(Failure(message: response.data['error']));
    } on DioException catch (e) {
      if (e.response != null) {
        print("error: " + e.response!.data['error']);
        return Left(Failure(message: e.response!.data['error']));
      } else {
        print("catch: " + e.toString());
        return Left(Failure(message: "Error exists please try again"));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(
      String fullName, String email, String password) async {
    try {
      final user = {"fullName": fullName, "email": email, "password": password};

      final response =
          await dio.post("http://192.168.98.27:8080/register", data: user);
      if (response.statusCode == 200) {
        return Right(null);
      }
      // print("error" + response.data['error']);
      return Left(Failure(message: response.data['error']));
    } on DioException catch (e) {
      if (e.response != null) {
        // print("error: " + e.response!.data['error']);
        return Left(Failure(message: e.response!.data['error']));
      } else {
        // print("error: " + e.toString());
        return Left(Failure(message: "Error exists please try again"));
      }
    } catch (e) {
      // print("catch" + e.toString());
      return Left(Failure(message: e.toString()));
    }
  }
}
