import 'package:dartz/dartz.dart';
import '../../entities/reviews/reviews_entity.dart';
import '../../repositories/reviews/reviews_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetReviewsUseCase implements UseCase<List<ReviewsEntity>, int> {
  final ReviewsRepository reviewsRepository;

  GetReviewsUseCase({
    required this.reviewsRepository,
  });

  @override
  Future<Either<Failure, List<ReviewsEntity>>> call(int movieId) async {
    Either<Failure, List<ReviewsEntity>> result =
        await reviewsRepository.getReviews(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
