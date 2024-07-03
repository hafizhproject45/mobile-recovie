import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/movie_list/movie_list_entity.dart';
import '../../../repositories/movies/movie_list/movie_list_repository.dart';

class GetRecomendationsUseCase implements UseCase<List<MovieListEntity>, int> {
  final MovieListRepository movieListRepository;

  GetRecomendationsUseCase({
    required this.movieListRepository,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>> call(int movieId) async {
    Either<Failure, List<MovieListEntity>> result =
        await movieListRepository.getRecomendationsMovieList(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
