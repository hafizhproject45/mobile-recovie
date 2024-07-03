import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../entities/movies/movie_list/movie_list_entity.dart';

abstract class SearchMovieRepository {
  Future<Either<Failure, List<MovieListEntity>>> searchMovie(String params);
}
