import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/movie_list/get_trending_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';

part 'get_trending_state.dart';

class GetTrendingCubit extends Cubit<GetTrendingState> {
  final GetTrendingUseCase getTrendingUseCase;

  GetTrendingCubit({
    required this.getTrendingUseCase,
  }) : super(const GetTrendingInitial());

  Future<void> getData() async {
    emit(const GetTrendingLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getTrendingUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetTrendingNotLoaded(message: l.message!)),
      (r) => emit(GetTrendingLoaded(data: r)),
    );
  }
}
