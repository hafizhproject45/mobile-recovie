import 'package:dartz/dartz.dart';
import '../../../entities/movies/detail_movie/genre_entity.dart';
import '../../../repositories/movies/detail_movie/detail_movie_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetGenreUseCase implements UseCase<List<GenreEntity>, int> {
  final DetailMovieRepository detailMovieRepository;

  GetGenreUseCase({
    required this.detailMovieRepository,
  });

  @override
  Future<Either<Failure, List<GenreEntity>>> call(int movieId) async {
    Either<Failure, List<GenreEntity>> result =
        await detailMovieRepository.getGenre(movieId);

    return result.fold(
      (failure) => Left(failure),
      (value) => Right(value),
    );
  }
}
