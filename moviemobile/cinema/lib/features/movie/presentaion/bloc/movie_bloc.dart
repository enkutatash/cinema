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
  MovieBloc({
    required this.getMoviesUsecase,
  }) : super(MovieState()) {
    on<FetchMovie>(_movieFetch);
  }

  FutureOr<void> _movieFetch(FetchMovie event, Emitter<MovieState> emit) async{
    emit(state.copyWith(status: MoviePageStatus.loading));
    var result = await getMoviesUsecase.execute();
    result.fold((failure) {
      emit(state.copyWith(status: MoviePageStatus.failed));
    }, (movies) {
      emit(state.copyWith(movies: movies, status: MoviePageStatus.success));
    });
  }
}
