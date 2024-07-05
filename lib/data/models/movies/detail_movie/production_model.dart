import '../../../../domain/entities/movies/detail_movie/production_entity.dart';

class ProductionModel extends ProductionEntity {
  const ProductionModel({
    required super.id,
    super.name,
    super.logoPath,
    super.originCountry,
  });

  //create factory
  factory ProductionModel.fromJson(Map<String, dynamic> json) =>
      ProductionModel(
        id: json['id'],
        name: json['name'],
        logoPath: json['logo_path'],
        originCountry: json['origin_country'],
      );
}
