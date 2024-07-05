import 'package:dartz/dartz.dart';
import '../../../entities/movies/detail_movie/main_detail_entity.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetMainDetailUseCase implements UseCase<MainDetailEntity, int> {
  final DetailMovieRepository detailMovieRepository;

  GetMainDetailUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, MainDetailEntity>> call(int movieId) async {
    Either<Failure, MainDetailEntity> result =
        await detailMovieRepository.getMainDetail(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
