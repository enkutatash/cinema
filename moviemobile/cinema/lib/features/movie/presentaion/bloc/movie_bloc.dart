import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:cinema/features/movie/domain/usecase/movie_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  GetMoviesUsecase getMoviesUsecase;
  GetMovieScheduleUsecase getMovieScheduleUsecase;
  MovieBloc({
    required this.getMoviesUsecase,
    required this.getMovieScheduleUsecase,
  }) : super(MovieState()) {
    on<FetchMovie>(_movieFetch);
    on<FetchShowTime>(_showtimeFetch);
  }

  FutureOr<void> _movieFetch(FetchMovie event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MoviePageStatus.loading));
    var result = await getMoviesUsecase.execute();
    result.fold((failure) {
      emit(state.copyWith(status: MoviePageStatus.failed));
    }, (movies) {
      emit(state.copyWith(movies: movies, status: MoviePageStatus.success));
    });
  }

  FutureOr<void> _showtimeFetch(
      FetchShowTime event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MoviePageStatus.loading));
   
    var result = await getMovieScheduleUsecase.execute();
    result.fold((failure) {
      print("failure"+failure.message);
      emit(state.copyWith(status: MoviePageStatus.failed));
    }, (showtime) {
      print("showtime: ${showtime[0].movie}");
      emit(
          state.copyWith(schedules: showtime, status: MoviePageStatus.success));
    });
  }
}
