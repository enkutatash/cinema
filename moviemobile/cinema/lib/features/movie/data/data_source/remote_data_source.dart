import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/movie/data/domain/domain.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RemoveDataSourceMovie {
  final Dio dio;
  RemoveDataSourceMovie({required this.dio});

  Future<Either<Failure, List<MovieModel>>> getMovies() async {
    try {
      final response = await dio.get("http://192.168.122.235:8080/user/movie",
          options: Options(headers: {
            "Authorization":
                "Bearer ${"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6IjY2ZmMyZmM2MDA1ODc5MzVlZmY1MDg2NSIsIkZ1bGxOYW1lIjoiRW5rdXRhdGFzaCBFc2hldHUiLCJFbWFpbCI6ImVua3VAZXhhbXBsZS5jb20iLCJQYXNzd29yZCI6IiIsIlJvbGUiOiJhZG1pbiIsImV4cCI6MTc1OTMzOTMzNH0.9kTvwZ_RrnxVugM0q7r6dq7tc0yGDATpamWnnG71-2Q"}"
          }));

      if (response.statusCode == 200) {
        final responseData = response.data;
        List<MovieModel> movies = [];
        for (var item in responseData) {
          movies.add(MovieModel.fromJson(item));
        }
        return Right(movies);
      }
      return Left(Failure(message: response.data['error']));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, MovieModel>> getMoviesById(String movieId) async {
    try {
      final response = await dio.get("http://192.168.122.235:8080/user/movie/$movieId",
          options: Options(headers: {
            "Authorization":
                "Bearer ${"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6IjY2ZmMyZmM2MDA1ODc5MzVlZmY1MDg2NSIsIkZ1bGxOYW1lIjoiRW5rdXRhdGFzaCBFc2hldHUiLCJFbWFpbCI6ImVua3VAZXhhbXBsZS5jb20iLCJQYXNzd29yZCI6IiIsIlJvbGUiOiJhZG1pbiIsImV4cCI6MTc1OTMzOTMzNH0.9kTvwZ_RrnxVugM0q7r6dq7tc0yGDATpamWnnG71-2Q"}"
          }));

      if (response.statusCode == 200) {
        final responseData = response.data;
        return Right(MovieModel.fromJson(responseData));
      }
      return Left(Failure(message: response.data['error']));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<ScheduleModel>>> getMoviesSchedules() async {
    try {
      final response =
          await dio.get("http://192.168.122.235:8080/user/movie/showtime",
              options: Options(headers: {
                "Authorization":
                    "Bearer ${"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6IjY2ZmMyZmM2MDA1ODc5MzVlZmY1MDg2NSIsIkZ1bGxOYW1lIjoiRW5rdXRhdGFzaCBFc2hldHUiLCJFbWFpbCI6ImVua3VAZXhhbXBsZS5jb20iLCJQYXNzd29yZCI6IiIsIlJvbGUiOiJhZG1pbiIsImV4cCI6MTc1OTMzOTMzNH0.9kTvwZ_RrnxVugM0q7r6dq7tc0yGDATpamWnnG71-2Q"}"
              }));
      
      if (response.statusCode == 200) {

        final responseData = response.data;
        List<ScheduleModel> movies = [];
        for (var item in responseData) {
          movies.add(ScheduleModel.fromJson(item));
        }
        return Right(movies);
      }
      return Left(Failure(message: response.data['error']));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
