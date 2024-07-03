// ignore_for_file: overridden_fields

part of 'get_popular_cubit.dart';

abstract class GetPopularState extends Equatable {
  final String? message;

  const GetPopularState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetPopularInitial extends GetPopularState {
  const GetPopularInitial() : super(null);
}

final class GetPopularLoading extends GetPopularState {
  const GetPopularLoading() : super(null);
}

final class GetPopularLoaded extends GetPopularState {
  final List<MovieListEntity?> data;

  const GetPopularLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetPopularNotLoaded extends GetPopularState {
  @override
  final String? message;

  const GetPopularNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
