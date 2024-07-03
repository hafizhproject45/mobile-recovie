// ignore_for_file: overridden_fields

part of 'get_trending_cubit.dart';

abstract class GetTrendingState extends Equatable {
  final String? message;

  const GetTrendingState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetTrendingInitial extends GetTrendingState {
  const GetTrendingInitial() : super(null);
}

final class GetTrendingLoading extends GetTrendingState {
  const GetTrendingLoading() : super(null);
}

final class GetTrendingLoaded extends GetTrendingState {
  final List<MovieListEntity?> data;

  const GetTrendingLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetTrendingNotLoaded extends GetTrendingState {
  @override
  final String? message;

  const GetTrendingNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
