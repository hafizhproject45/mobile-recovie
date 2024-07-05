import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/detail_movie/teaser_entity.dart';
import '../../../../domain/usecases/movies/detail_movie/get_teaser_usecase.dart';

part 'get_teaser_state.dart';

class GetTeaserCubit extends Cubit<GetTeaserState> {
  final GetTeaserUseCase getTeaserUseCase;

  GetTeaserCubit({
    required this.getTeaserUseCase,
  }) : super(const GetTeaserInitial());

  Future<void> getData(int movieId) async {
    emit(const GetTeaserLoading());

    Either<Failure, List<TeaserEntity>> result =
        await getTeaserUseCase.call(movieId);

    result.fold(
      (l) => emit(GetTeaserNotLoaded(message: l.message!)),
      (r) => emit(GetTeaserLoaded(data: r)),
    );
  }
}
