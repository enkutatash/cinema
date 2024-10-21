import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:equatable/equatable.dart';

class CastModel extends Cast {
  CastModel({
    required String name,
    required String image,
    required String role,
  }) : super(name: name, image: image, role: role);

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'],
      image: json['image'] ?? '', // Handle missing image field if necessary
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'role': role,
    };
  }
}

class MovieModel extends MovieEntity {
  MovieModel({
    required String movieId,
    required String title,
    required String poster,
    required String description,
    required String genre,
    required String releaseDate,
    required String duration,
    required String trailer,
    required List<CastModel> cast,
  }) : super(
          movieId: movieId,
          title: title,
          poster: poster,
          description: description,
          genre: genre,
          releaseDate: releaseDate,
          duration: duration,
          trailer: trailer,
          cast: cast,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      movieId: json['movieid'],
      title: json['title'],
      poster: json['poster'],
      description: json['description'],
      genre: json['genre'],
      releaseDate: json['year'], // Assuming 'year' is used as releaseDate
      duration: json['duration'],
      trailer: json['trailer'],
      cast: (json['cast'] as List)
          .map((item) => CastModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movieid': movieId,
      'title': title,
      'poster': poster,
      'description': description,
      'genre': genre,
      'year': releaseDate, // Assuming 'year' is used as releaseDate
      'duration': duration,
      'trailer': trailer,
      'cast': cast.map((item) => item.toJson()).toList(),
    };
  }
}
