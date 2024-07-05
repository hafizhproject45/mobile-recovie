// ignore_for_file: overridden_fields

part of 'get_genre_cubit.dart';

abstract class GetGenreState extends Equatable {
  final String? message;

  const GetGenreState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetGenreInitial extends GetGenreState {
  const GetGenreInitial() : super(null);
}

final class GetGenreLoading extends GetGenreState {
  const GetGenreLoading() : super(null);
}

final class GetGenreLoaded extends GetGenreState {
  final List<GenreEntity?> data;

  const GetGenreLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetGenreNotLoaded extends GetGenreState {
  @override
  final String? message;

  const GetGenreNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
