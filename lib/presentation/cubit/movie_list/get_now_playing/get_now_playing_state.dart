// ignore_for_file: overridden_fields

part of 'get_now_playing_cubit.dart';

abstract class GetNowPlayingState extends Equatable {
  final String? message;

  const GetNowPlayingState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetNowPlayingInitial extends GetNowPlayingState {
  const GetNowPlayingInitial() : super(null);
}

final class GetNowPlayingLoading extends GetNowPlayingState {
  const GetNowPlayingLoading() : super(null);
}

final class GetNowPlayingLoaded extends GetNowPlayingState {
  final List<MovieListEntity?> data;

  const GetNowPlayingLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetNowPlayingNotLoaded extends GetNowPlayingState {
  @override
  final String? message;

  const GetNowPlayingNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
