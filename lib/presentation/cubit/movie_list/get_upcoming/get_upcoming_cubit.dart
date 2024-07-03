import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/movie_list/get_upcoming_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';

part 'get_upcoming_state.dart';

class GetUpcomingCubit extends Cubit<GetUpcomingState> {
  final GetUpComingUseCase getUpComingUseCase;

  GetUpcomingCubit({
    required this.getUpComingUseCase,
  }) : super(const GetUpcomingInitial());

  Future<void> getData() async {
    emit(const GetUpcomingLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getUpComingUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetUpcomingNotLoaded(message: l.message!)),
      (r) => emit(GetUpcomingLoaded(data: r)),
    );
  }
}
