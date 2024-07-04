import 'package:dartz/dartz.dart';

import '../../../entities/movies/detail_movie/teaser_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class TeaserRepository {
  Future<Either<Failure, List<TeaserEntity>>> getTeaser(int movieId);
}
