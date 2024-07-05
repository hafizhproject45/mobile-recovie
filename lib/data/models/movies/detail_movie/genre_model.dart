import '../../../../domain/entities/movies/detail_movie/genre_entity.dart';

class GenreModel extends GenreEntity {
  const GenreModel({
    super.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      name: json['name'],
    );
  }
}
