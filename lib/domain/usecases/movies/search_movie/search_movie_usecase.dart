import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/movie_list/movie_list_entity.dart';
import '../../../repositories/movies/search_movie/search_movie_repository.dart';

class SearchMovieUseCase implements UseCase<List<MovieListEntity>, String> {
  final SearchMovieRepository searchMovieRepository;

  SearchMovieUseCase({
    required this.searchMovieRepository,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>> call(String params) async {
    Either<Failure, List<MovieListEntity>> result =
        await searchMovieRepository.searchMovie(params);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
