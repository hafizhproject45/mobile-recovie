import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';

class MovieListModel extends MovieListEntity {
  const MovieListModel({
    required super.id,
    super.oriTitle,
    super.oriLanguage,
    super.overview,
    super.popularity,
    super.posterPath,
    super.title,
    super.voteAverage,
    super.voteCount,
    super.releaseDate,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) {
    return MovieListModel(
      id: json['id'],
      oriTitle: json['original_title'],
      oriLanguage: json['original_language'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      title: json['title'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
    );
  }
}
