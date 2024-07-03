import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/reviews/reviews_entity.dart';
import '../../../../domain/usecases/reviews/get_reviews_usecase.dart';
import '../../../../core/errors/failures.dart';

part 'get_reviews_state.dart';

class GetReviewsCubit extends Cubit<GetReviewsState> {
  final GetReviewsUseCase getReviewsUseCase;

  GetReviewsCubit({
    required this.getReviewsUseCase,
  }) : super(const GetReviewsInitial());

  Future<void> getData(int movieId) async {
    emit(const GetReviewsLoading());

    Either<Failure, List<ReviewsEntity>> result =
        await getReviewsUseCase.call(movieId);

    result.fold(
      (l) => emit(GetReviewsNotLoaded(message: l.message!)),
      (r) => emit(GetReviewsLoaded(data: r)),
    );
  }
}
