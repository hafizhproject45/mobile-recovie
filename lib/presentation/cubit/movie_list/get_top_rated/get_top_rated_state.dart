// ignore_for_file: overridden_fields

part of 'get_top_rated_cubit.dart';

abstract class GetTopRatedState extends Equatable {
  final String? message;

  const GetTopRatedState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetTopRatedInitial extends GetTopRatedState {
  const GetTopRatedInitial() : super(null);
}

final class GetTopRatedLoading extends GetTopRatedState {
  const GetTopRatedLoading() : super(null);
}

final class GetTopRatedLoaded extends GetTopRatedState {
  final List<MovieListEntity?> data;

  const GetTopRatedLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetTopRatedNotLoaded extends GetTopRatedState {
  @override
  final String? message;

  const GetTopRatedNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
