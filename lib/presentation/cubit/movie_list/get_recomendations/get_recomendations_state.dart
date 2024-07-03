// ignore_for_file: overridden_fields

part of 'get_recomendations_cubit.dart';

abstract class GetRecomendationsState extends Equatable {
  final String? message;

  const GetRecomendationsState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetRecomendationsInitial extends GetRecomendationsState {
  const GetRecomendationsInitial() : super(null);
}

final class GetRecomendationsLoading extends GetRecomendationsState {
  const GetRecomendationsLoading() : super(null);
}

final class GetRecomendationsLoaded extends GetRecomendationsState {
  final List<MovieListEntity?> data;

  const GetRecomendationsLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetRecomendationsNotLoaded extends GetRecomendationsState {
  @override
  final String? message;

  const GetRecomendationsNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
