import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/core/network/network.dart';
import 'package:cinema/features/movie/data/data_source/remote_data_source.dart';
import 'package:cinema/features/movie/data/domain/domain.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:cinema/features/movie/domain/repository/movie_repo.dart';
import 'package:dartz/dartz.dart';

class MovierepoImp extends MovieRepo {
  RemoveDataSourceMovie remoteDataSource;
  NetworkInfo networkInfo;
  MovierepoImp({required this.remoteDataSource, required this.networkInfo});
  @override
  Future<Either<Failure, void>> addMovie(MovieEntity movie) {
    // TODO: implement addMovie
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> buyTicket(MovieEntity movie) {
    // TODO: implement buyTicket
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteMovie(MovieEntity movie) {
    // TODO: implement deleteMovie
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> getMovieSchedules() {
    // TODO: implement getMovieSchedules
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getMovies() async {
    try {
      if (await networkInfo.isConnected) {
        final movies = await remoteDataSource.getMovies();
        return movies.fold((failure) {
          return Left(failure);
        }, (moviesList) {
          return Right(moviesList);
        });
      }
      return Left(Failure(message: "No Internet Connection"));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateMovie(MovieEntity movie) {
    // TODO: implement updateMovie
    throw UnimplementedError();
  }
}
