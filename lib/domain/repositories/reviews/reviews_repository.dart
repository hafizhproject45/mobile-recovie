import 'package:dartz/dartz.dart';
import '../../entities/reviews/reviews_entity.dart';

import '../../../core/errors/failures.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<ReviewsEntity>>> getReviews(int movieId);
}
