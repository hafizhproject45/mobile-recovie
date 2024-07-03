// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../data/datasources/reviews/reviews_datasource.dart';
import '../../../domain/entities/reviews/reviews_entity.dart';
import '../../../domain/repositories/reviews/reviews_repository.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/utils/constants.dart';

class ReviewsRepositoryImpl extends ReviewsRepository {
  final ReviewsDataSource reviewsDataSource;

  ReviewsRepositoryImpl({
    required this.reviewsDataSource,
  });

  @override
  Future<Either<Failure, List<ReviewsEntity>>> getReviews(int movieId) async {
    try {
      List<ReviewsEntity> data = await reviewsDataSource.getReviews(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }
}
