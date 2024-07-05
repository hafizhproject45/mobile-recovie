import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/detail_movie/get_genre_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/detail_movie/genre_entity.dart';

part 'get_genre_state.dart';

class GetGenreCubit extends Cubit<GetGenreState> {
  GetGenreUseCase getGenreUseCase;

  GetGenreCubit({
    required this.getGenreUseCase,
  }) : super(const GetGenreInitial());

  Future<void> getData(int movieId) async {
    emit(const GetGenreLoading());

    Either<Failure, List<GenreEntity>> result =
        await getGenreUseCase.call(movieId);

    result.fold(
      (l) => emit(GetGenreNotLoaded(message: l.message!)),
      (r) => emit(GetGenreLoaded(data: r)),
    );
  }
}
