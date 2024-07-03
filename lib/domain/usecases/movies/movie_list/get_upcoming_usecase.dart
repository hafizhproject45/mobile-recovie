import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../entities/movies/movie_list/movie_list_entity.dart';
import '../../../repositories/movies/movie_list/movie_list_repository.dart';

class GetUpComingUseCase implements UseCase<List<MovieListEntity>, NoParams> {
  final MovieListRepository movieListRepository;

  GetUpComingUseCase({
    required this.movieListRepository,
  });

  @override
  Future<Either<Failure, List<MovieListEntity>>> call(NoParams params) async {
    Either<Failure, List<MovieListEntity>> result =
        await movieListRepository.getUpComingMovieList();

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}