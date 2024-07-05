// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:recovie/core/errors/failures.dart';
import 'package:recovie/data/datasources/movies/detail_movie/detail_movie_datasource.dart';
import 'package:recovie/domain/entities/movies/detail_movie/credits_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/genre_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/image_poster_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/main_detail_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/production_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/teaser_entity.dart';
import 'package:recovie/domain/repositories/movies/detail_movie/detail_movie_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';

class DetailMovieRepositoryImpl extends DetailMovieRepository {
  final DetailMovieDataSource detailMovieDataSource;

  DetailMovieRepositoryImpl({
    required this.detailMovieDataSource,
  });

  @override
  Future<Either<Failure, List<CreditsEntity>>> getCredits(int movieId) async {
    try {
      List<CreditsEntity> data =
          await detailMovieDataSource.getCredits(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }

  @override
  Future<Either<Failure, List<ImagePosterEntity>>> getImagePoster(
      int movieId) async {
    try {
      List<ImagePosterEntity> data =
          await detailMovieDataSource.getImagePoster(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }

  @override
  Future<Either<Failure, List<TeaserEntity>>> getTeaser(int movieId) async {
    try {
      List<TeaserEntity> data = await detailMovieDataSource.getTeaser(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }

  @override
  Future<Either<Failure, MainDetailEntity>> getMainDetail(int movieId) async {
    try {
      MainDetailEntity data =
          await detailMovieDataSource.getMainDetail(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }

  @override
  Future<Either<Failure, List<GenreEntity>>> getGenre(int movieId) async {
    try {
      List<GenreEntity> data = await detailMovieDataSource.getGenre(movieId);

      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(message: e.message));
      } else {
        return const Left(UnknownFailure(message: FAILURE_UNKNOWN));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductionEntity>>> getProduction(
      int movieId) async {
    try {
      List<ProductionEntity> data =
          await detailMovieDataSource.getProduction(movieId);

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
