import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/movies/detail_movie/image_poster_entity.dart';
import '../../../../domain/usecases/movies/detail_movie/get_image_poster_usecase.dart';

part 'get_image_poster_state.dart';

class GetImagePosterCubit extends Cubit<GetImagePosterState> {
  final GetImagePosterUseCase getImagePosterUseCase;

  GetImagePosterCubit({
    required this.getImagePosterUseCase,
  }) : super(const GetImagePosterInitial());

  Future<void> getData(int movieId) async {
    emit(const GetImagePosterLoading());

    Either<Failure, List<ImagePosterEntity>> result =
        await getImagePosterUseCase.call(movieId);

    result.fold(
      (l) => emit(GetImagePosterNotLoaded(message: l.message!)),
      (r) => emit(GetImagePosterLoaded(data: r)),
    );
  }
}
