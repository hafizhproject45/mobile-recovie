import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/movie_list/movie_list_entity.dart';
import '../../../repositories/movies/movie_list/movie_list_repository.dart';

class GetPopularUseCase implements UseCase<List<MovieListEntity>, NoParams> {
  final MovieListRepository movieListRepository;

  GetPopularUseCase({
    required this.movieListRepository,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>> call(NoParams params) async {
    Either<Failure, List<MovieListEntity>> result =
        await movieListRepository.getPopularMovieList();

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
