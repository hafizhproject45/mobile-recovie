import 'package:dartz/dartz.dart';
import '../../../entities/movies/detail_movie/image_poster_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class ImagePosterRepository {
  Future<Either<Failure, List<ImagePosterEntity>>> getImagePoster(int movieId);
}
