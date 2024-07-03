// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../data/datasources/movies/search_movie/search_movie_datasource.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../domain/repositories/movies/search_movie/search_movie_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';

class SearchMovieRepositoryImpl extends SearchMovieRepository {
  final SearchMovieDataSource searchMovieDataSource;

  SearchMovieRepositoryImpl({
    required this.searchMovieDataSource,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>> searchMovie(
      String params) async {
    try {
      final data = await searchMovieDataSource.searchMovie(params);

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
