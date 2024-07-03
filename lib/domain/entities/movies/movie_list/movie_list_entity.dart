import 'package:equatable/equatable.dart';

class MovieListEntity extends Equatable {
  final int id;
  final String? oriTitle;
  final String? oriLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? title;
  final double? voteAverage;
  final int? voteCount;
  final String? releaseDate;

  const MovieListEntity({
    required this.id,
    this.oriTitle,
    this.oriLanguage,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.releaseDate,
  });

  @override
  List<Object?> get props {
    return [
      id,
      oriTitle,
      oriLanguage,
      overview,
      popularity,
      posterPath,
      title,
      voteAverage,
      voteCount,
      releaseDate,
    ];
  }
}
