// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../data/datasources/movies/movie_list/movie_list_datasource.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../domain/repositories/movies/movie_list/movie_list_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';

class MovieListReposisoryImpl extends MovieListRepository {
  final MovieListDataSource movieListDataSource;

  MovieListReposisoryImpl({
    required this.movieListDataSource,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>>
      getNowPlayingMovieList() async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getNowPlayingMovieList();

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
  Future<Either<Failure, List<MovieListEntity>>> getTopRatedMovieList() async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getTopRatedMovieList();

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
  Future<Either<Failure, List<MovieListEntity>>> getPopularMovieList() async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getPopuluarMovieList();

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
  Future<Either<Failure, List<MovieListEntity>>> getUpComingMovieList() async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getUpComingMovieList();

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
  Future<Either<Failure, List<MovieListEntity>>> getTrendingMovieList() async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getTrendingMovieList();

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
  Future<Either<Failure, List<MovieListEntity>>> getRecomendationsMovieList(
      int movieId) async {
    try {
      List<MovieListEntity> data =
          await movieListDataSource.getRecomendationsMovieList(movieId);

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
