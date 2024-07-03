import 'package:dartz/dartz.dart';

import '../../../entities/movies/movie_list/movie_list_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class MovieListRepository {
  Future<Either<Failure, List<MovieListEntity>>> getPopularMovieList();
  Future<Either<Failure, List<MovieListEntity>>> getNowPlayingMovieList();
  Future<Either<Failure, List<MovieListEntity>>> getTopRatedMovieList();
  Future<Either<Failure, List<MovieListEntity>>> getUpComingMovieList();
  Future<Either<Failure, List<MovieListEntity>>> getTrendingMovieList();
  Future<Either<Failure, List<MovieListEntity>>> getRecomendationsMovieList(
      int movieId);
}
