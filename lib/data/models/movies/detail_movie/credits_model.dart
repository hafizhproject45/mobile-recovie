import '../../../../domain/entities/movies/detail_movie/credits_entity.dart';

class CreditsModel extends CreditsEntity {
  const CreditsModel({
    required super.castId,
    super.knownFor,
    super.name,
    super.popularity,
    super.profilePath,
    super.castFor,
  });

  factory CreditsModel.fromJson(Map<String, dynamic> json) {
    return CreditsModel(
      castId: json['cast_id'],
      knownFor: json['known_for_department'],
      name: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'],
      castFor: json['character'],
    );
  }
}
