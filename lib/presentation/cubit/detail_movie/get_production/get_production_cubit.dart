import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/usecases/movies/detail_movie/get_production_usecase.dart';

import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/detail_movie/production_entity.dart';

part 'get_production_state.dart';

class GetProductionCubit extends Cubit<GetProductionState> {
  final GetProductionUseCase getProductionUseCase;

  GetProductionCubit({
    required this.getProductionUseCase,
  }) : super(const GetProductionInitial());

  Future<void> getData(int movieId) async {
    emit(const GetProductionLoading());

    Either<Failure, List<ProductionEntity>> result =
        await getProductionUseCase.call(movieId);

    result.fold(
      (l) => emit(GetProductionNotLoaded(message: l.message!)),
      (r) => emit(GetProductionLoaded(data: r)),
    );
  }
}
