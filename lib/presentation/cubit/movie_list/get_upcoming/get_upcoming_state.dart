// ignore_for_file: overridden_fields

part of 'get_upcoming_cubit.dart';

abstract class GetUpcomingState extends Equatable {
  final String? message;

  const GetUpcomingState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetUpcomingInitial extends GetUpcomingState {
  const GetUpcomingInitial() : super(null);
}

final class GetUpcomingLoading extends GetUpcomingState {
  const GetUpcomingLoading() : super(null);
}

final class GetUpcomingLoaded extends GetUpcomingState {
  final List<MovieListEntity?> data;

  const GetUpcomingLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetUpcomingNotLoaded extends GetUpcomingState {
  @override
  final String? message;

  const GetUpcomingNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
