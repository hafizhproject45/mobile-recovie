import '../../../../domain/entities/movies/detail_movie/main_detail_entity.dart';

class MainDetailModel extends MainDetailEntity {
  const MainDetailModel({
    super.adult,
    super.name,
    super.budget,
    super.revenue,
    super.runtime,
    super.status,
    super.tagline,
  });

  factory MainDetailModel.fromJson(Map<String, dynamic> json) {
    return MainDetailModel(
      adult: json['adult'],
      name: json['belongs_to_collection']['name'],
      budget: json['budget'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      status: json['status'],
      tagline: json['tagline'],
    );
  }
}
