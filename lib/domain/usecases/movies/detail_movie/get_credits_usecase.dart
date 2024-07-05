import 'package:dartz/dartz.dart';

import '../../../entities/movies/detail_movie/credits_entity.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetCreditsUseCase implements UseCase<List<CreditsEntity>, int> {
  final DetailMovieRepository detailMovieRepository;

  GetCreditsUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, List<CreditsEntity>>> call(int movieId) async {
    Either<Failure, List<CreditsEntity>> result =
        await detailMovieRepository.getCredits(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
