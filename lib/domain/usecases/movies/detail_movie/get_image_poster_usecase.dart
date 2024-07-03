import 'package:dartz/dartz.dart';
import '../../../entities/movies/detail_movie/image_poster_entity.dart';
import '../../../repositories/movies/detail_movie/image_poster_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetImagePosterUseCase implements UseCase<List<ImagePosterEntity>, int> {
  final ImagePosterRepository imagePosterRepository;

  GetImagePosterUseCase({
    required this.imagePosterRepository,
  });

  @override
  Future<Either<Failure, List<ImagePosterEntity>>> call(int movieId) async {
    Either<Failure, List<ImagePosterEntity>> result =
        await imagePosterRepository.getImagePoster(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
