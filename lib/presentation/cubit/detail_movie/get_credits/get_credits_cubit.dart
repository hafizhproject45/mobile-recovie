import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/movies/detail_movie/credits_entity.dart';
import '../../../../domain/usecases/movies/detail_movie/get_credits_usecase.dart';

import '../../../../core/errors/failures.dart';

part 'get_credits_state.dart';

class GetCreditsCubit extends Cubit<GetCreditsState> {
  final GetCreditsUseCase getCreditsUseCase;

  GetCreditsCubit({
    required this.getCreditsUseCase,
  }) : super(const GetCreditsInitial());

  Future<void> getData(int movieId) async {
    emit(const GetCreditsLoading());

    Either<Failure, List<CreditsEntity>> result =
        await getCreditsUseCase.call(movieId);

    result.fold(
      (l) => emit(GetCreditsNotLoaded(message: l.message!)),
      (r) => emit(GetCreditsLoaded(data: r)),
    );
  }
}
