// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../data/datasources/movies/detail_movie/image_poster_datasource.dart';
import '../../../../domain/entities/movies/detail_movie/image_poster_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../domain/repositories/movies/detail_movie/image_poster_repository.dart';

class ImagePosterRepositoryImpl extends ImagePosterRepository {
  final ImagePosterDataSource imagePosterDataSource;

  ImagePosterRepositoryImpl({
    required this.imagePosterDataSource,
  });

  @override
  Future<Either<Failure, List<ImagePosterEntity>>> getImagePoster(
      int movieId) async {
    try {
      List<ImagePosterEntity> data =
          await imagePosterDataSource.getImagePoster(movieId);

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
