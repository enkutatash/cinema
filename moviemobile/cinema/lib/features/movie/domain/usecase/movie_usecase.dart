import 'package:cinema/core/failure/failure.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:cinema/features/movie/domain/repository/movie_repo.dart';
import 'package:dartz/dartz.dart';

class GetMoviesUsecase{
  final MovieRepo movieRepository;
  GetMoviesUsecase({required this.movieRepository});
  
  Future<Either<Failure,List<MovieEntity>>> execute(){
    return movieRepository.getMovies();
  }
}

class GetMovieScheduleUsecase{
  final MovieRepo movieRepository;
  GetMovieScheduleUsecase({required this.movieRepository});
  
  Future<Either<Failure,void>> execute(){
    return movieRepository.getMovieSchedules();
  }
}

class AddMovieUsecase{
  final MovieRepo movieRepository;
  AddMovieUsecase({required this.movieRepository});
  
  Future<Either<Failure,void>> execute(MovieEntity movie){
    return movieRepository.addMovie(movie);
  }
}

class DeleteMovieUsecase{
  final MovieRepo movieRepository;
  DeleteMovieUsecase({required this.movieRepository});
  
  Future<Either<Failure,void>> execute(MovieEntity movie){
    return movieRepository.deleteMovie(movie);
  }
}

class UpdateMovieUsecase{
  final MovieRepo movieRepository;
  UpdateMovieUsecase({required this.movieRepository});
  
  Future<Either<Failure,void>> execute(MovieEntity movie){
    return movieRepository.updateMovie(movie);
  }
}

class BuyTicketUsecase{
  final MovieRepo movieRepository;
  BuyTicketUsecase({required this.movieRepository});
  
  Future<Either<Failure,void>> execute(MovieEntity movie){
    return movieRepository.buyTicket(movie);
  }
}

