import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepo {
  Future<Either<Failure,List<MovieEntity>>> getMovies();
  Future<Either<Failure,void>> addMovie(MovieEntity movie);
  Future<Either<Failure,void>> deleteMovie(MovieEntity movie);
  Future<Either<Failure,void>> updateMovie(MovieEntity movie);
  Future<Either<Failure,void>> buyTicket(MovieEntity movie);
  Future<Either<Failure,List<ScheduleEntity>>> getMovieSchedules();

}