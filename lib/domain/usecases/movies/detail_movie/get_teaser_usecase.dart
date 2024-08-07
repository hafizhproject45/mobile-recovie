import 'package:dartz/dartz.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/detail_movie/teaser_entity.dart';

class GetTeaserUseCase implements UseCase<List<TeaserEntity>, int> {
  final DetailMovieRepository detailMovieRepository;

  GetTeaserUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, List<TeaserEntity>>> call(int movieId) async {
    Either<Failure, List<TeaserEntity>> result =
        await detailMovieRepository.getTeaser(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
