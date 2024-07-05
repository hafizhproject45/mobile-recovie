import 'package:dartz/dartz.dart';
import '../../../entities/movies/detail_movie/production_entity.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetProductionUseCase implements UseCase<List<ProductionEntity>, int> {
  final DetailMovieRepository detailMovieRepository;

  GetProductionUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, List<ProductionEntity>>> call(int movieId) async {
    Either<Failure, List<ProductionEntity>> result =
        await detailMovieRepository.getProduction(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
