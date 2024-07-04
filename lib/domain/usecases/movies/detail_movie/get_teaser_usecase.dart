import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/detail_movie/teaser_entity.dart';
import '../../../repositories/movies/detail_movie/teaser_repository.dart';

class GetTeaserUseCase implements UseCase<List<TeaserEntity>, int> {
  final TeaserRepository teaserRepository;

  GetTeaserUseCase({
    required this.teaserRepository,
  });

  @override
  Future<Either<Failure, List<TeaserEntity>>> call(int movieId) async {
    Either<Failure, List<TeaserEntity>> result =
        await teaserRepository.getTeaser(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
