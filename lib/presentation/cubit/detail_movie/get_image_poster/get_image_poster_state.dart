// ignore_for_file: overridden_fields

part of 'get_image_poster_cubit.dart';

abstract class GetImagePosterState extends Equatable {
  final String? message;

  const GetImagePosterState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetImagePosterInitial extends GetImagePosterState {
  const GetImagePosterInitial() : super(null);
}

final class GetImagePosterLoading extends GetImagePosterState {
  const GetImagePosterLoading() : super(null);
}

final class GetImagePosterLoaded extends GetImagePosterState {
  final List<ImagePosterEntity?> data;

  const GetImagePosterLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetImagePosterNotLoaded extends GetImagePosterState {
  @override
  final String? message;

  const GetImagePosterNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
