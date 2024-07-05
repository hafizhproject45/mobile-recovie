import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/usecases/movies/detail_movie/get_main_detail_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/detail_movie/main_detail_entity.dart';

part 'get_main_detail_state.dart';

class GetMainDetailCubit extends Cubit<GetMainDetailState> {
  final GetMainDetailUseCase getMainDetailUseCase;

  GetMainDetailCubit({
    required this.getMainDetailUseCase,
  }) : super(const GetMainDetailInitial());

  Future<void> getData(int movieId) async {
    emit(const GetMainDetailLoading());

    Either<Failure, MainDetailEntity> result =
        await getMainDetailUseCase.call(movieId);

    result.fold(
      (l) => emit(GetMainDetailNotLoaded(message: l.message!)),
      (r) => emit(GetMainDetailLoaded(data: r)),
    );
  }
}
