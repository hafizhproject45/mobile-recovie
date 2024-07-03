import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/movie_list/get_top_rated_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';

part 'get_top_rated_state.dart';

class GetTopRatedCubit extends Cubit<GetTopRatedState> {
  final GetTopRatedUseCase getTopRatedUseCase;

  GetTopRatedCubit({
    required this.getTopRatedUseCase,
  }) : super(const GetTopRatedInitial());

  Future<void> getData() async {
    emit(const GetTopRatedLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getTopRatedUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetTopRatedNotLoaded(message: l.message!)),
      (r) => emit(GetTopRatedLoaded(data: r)),
    );
  }
}
