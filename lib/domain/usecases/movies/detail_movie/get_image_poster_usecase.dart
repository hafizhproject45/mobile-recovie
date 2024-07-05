import 'package:dartz/dartz.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';
import '../../../entities/movies/detail_movie/image_poster_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetImagePosterUseCase implements UseCase<List<ImagePosterEntity>, int> {
  final DetailMovieRepository detailMovieRepository;

  GetImagePosterUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, List<ImagePosterEntity>>> call(int movieId) async {
    Either<Failure, List<ImagePosterEntity>> result =
        await detailMovieRepository.getImagePoster(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
