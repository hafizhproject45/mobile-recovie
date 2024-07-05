import 'package:dartz/dartz.dart';

import '../../../entities/movies/detail_movie/genre_entity.dart';
import '../../../entities/movies/detail_movie/production_entity.dart';
import '../../../entities/movies/detail_movie/credits_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../entities/movies/detail_movie/image_poster_entity.dart';
import '../../../entities/movies/detail_movie/main_detail_entity.dart';
import '../../../entities/movies/detail_movie/teaser_entity.dart';

abstract class DetailMovieRepository {
  Future<Either<Failure, MainDetailEntity>> getMainDetail(int movieId);
  Future<Either<Failure, List<ImagePosterEntity>>> getImagePoster(int movieId);
  Future<Either<Failure, List<TeaserEntity>>> getTeaser(int movieId);
  Future<Either<Failure, List<CreditsEntity>>> getCredits(int movieId);
  Future<Either<Failure, List<GenreEntity>>> getGenre(int movieId);
  Future<Either<Failure, List<ProductionEntity>>> getProduction(int movieId);
}
