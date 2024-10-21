part of 'movie_bloc.dart';


enum MoviePageStatus { initial, loading, success, failed }

class MovieState extends Equatable {
  final List<MovieEntity> movies;
  final List<ScheduleEntity >schedules;
  final MoviePageStatus status;
   MovieState({
    this.movies =const <MovieEntity>[] ,
    this.schedules = const <ScheduleEntity>[],
    this.status = MoviePageStatus.initial,
   });

  MovieState copyWith({
    List<MovieEntity>? movies,
    List<ScheduleEntity>? schedules,
    MoviePageStatus? status,
  }) {
    return MovieState(
      movies: movies ?? this.movies,
      schedules: schedules ?? this.schedules,
      status: status ?? this.status,
    );
  }
  @override
  List<Object> get props => [movies, schedules, status];
}
