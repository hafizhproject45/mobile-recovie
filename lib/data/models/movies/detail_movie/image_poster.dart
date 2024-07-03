import '../../../../domain/entities/movies/detail_movie/image_poster_entity.dart';

class ImagePosterModel extends ImagePosterEntity {
  const ImagePosterModel({
    super.filePath,
  });

  factory ImagePosterModel.fromJson(Map<String, dynamic> json) {
    return ImagePosterModel(
      filePath: json['file_path'],
    );
  }
}
