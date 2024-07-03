import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/movie_list/get_recomendations_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';

part 'get_recomendations_state.dart';

class GetRecomendationsCubit extends Cubit<GetRecomendationsState> {
  final GetRecomendationsUseCase getRecomendationsUseCase;

  GetRecomendationsCubit({
    required this.getRecomendationsUseCase,
  }) : super(const GetRecomendationsInitial());

  Future<void> getData(int movieId) async {
    emit(const GetRecomendationsLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getRecomendationsUseCase.call(movieId);

    result.fold(
      (l) => emit(GetRecomendationsNotLoaded(message: l.message!)),
      (r) => emit(GetRecomendationsLoaded(data: r)),
    );
  }
}
