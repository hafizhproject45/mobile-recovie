import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../domain/usecases/movies/movie_list/get_popular_usecase.dart';

part 'get_popular_state.dart';

class GetPopularCubit extends Cubit<GetPopularState> {
  final GetPopularUseCase getPopularUseCase;

  GetPopularCubit({
    required this.getPopularUseCase,
  }) : super(const GetPopularInitial());

  Future<void> getData() async {
    emit(const GetPopularLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getPopularUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetPopularNotLoaded(message: l.message!)),
      (r) => emit(GetPopularLoaded(data: r)),
    );
  }
}
