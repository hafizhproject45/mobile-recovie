import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../domain/usecases/movies/movie_list/get_now_playing_usecase.dart';

part 'get_now_playing_state.dart';

class GetNowPlayingCubit extends Cubit<GetNowPlayingState> {
  final GetNowPlayingUseCase getNowPlayingUseCase;

  GetNowPlayingCubit({
    required this.getNowPlayingUseCase,
  }) : super(const GetNowPlayingInitial());

  Future<void> getData() async {
    emit(const GetNowPlayingLoading());

    Either<Failure, List<MovieListEntity>> result =
        await getNowPlayingUseCase.call(NoParams());

    result.fold(
      (l) => emit(GetNowPlayingNotLoaded(message: l.message!)),
      (r) => emit(GetNowPlayingLoaded(data: r)),
    );
  }
}
