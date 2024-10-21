part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable{
  const MovieEvent();
}

class FetchMovie extends MovieEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

