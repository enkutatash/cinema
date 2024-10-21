import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String movieId;
  final String title;
  final String poster;
  final String description;
  final String genre;
  final String releaseDate;
  final String duration;
  final String trailer;
  final List<Cast> cast;
  MovieEntity({
    this.movieId = "",
    required this.title,
    required this.poster,
    required this.description,
    required this.genre,
    required this.releaseDate,
    required this.duration,
    required this.trailer,
    required this.cast,
  });
  @override
  // TODO: implement props
  List<Object?> get props =>
      [title, poster, description, genre, releaseDate, duration, trailer, cast];
}

class Cast {
  String name;
  String image;
  String role;
  Cast({required this.name, required this.image, required this.role});
   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'role': role,
    };
  }
}

class ScheduleEntity{
  final String scheduleId;
  final String movieId;
  final String date;
  final String time;
  final String hall;
  final String price;
  final String availableSeats;
  ScheduleEntity({
    required this.scheduleId,
    required this.movieId,
    required this.date,
    required this.time,
    required this.hall,
    required this.price,
    required this.availableSeats,
  });
}