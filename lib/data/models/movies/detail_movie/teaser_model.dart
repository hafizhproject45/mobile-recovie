import '../../../../domain/entities/movies/detail_movie/teaser_entity.dart';

class TeaserModel extends TeaserEntity {
  const TeaserModel({
    required super.id,
    super.key,
    super.name,
    super.official,
    super.publishedAt,
    super.site,
    super.size,
    super.type,
  });

  factory TeaserModel.fromJson(Map<String, dynamic> json) {
    return TeaserModel(
      id: json["id"],
      key: json["key"],
      name: json["name"],
      official: json["official"],
      publishedAt: json["published_at"],
      site: json["site"],
      size: json['size'],
      type: json['type'],
    );
  }
}
