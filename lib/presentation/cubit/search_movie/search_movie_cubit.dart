import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/usecases/movies/search_movie/search_movie_usecase.dart';

import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final SearchMovieUseCase searchMovieUseCase;

  SearchMovieCubit({
    required this.searchMovieUseCase,
  }) : super(const SearchMovieInitial());

  Future<void> searchMovie(String params) async {
    emit(const SearchMovieLoading());

    Either<Failure, List<MovieListEntity>> result =
        await searchMovieUseCase.call(params);

    result.fold(
      (l) => emit(SearchMovieNotLoaded(message: l.message!)),
      (r) => emit(SearchMovieLoaded(data: r)),
    );
  }
}
