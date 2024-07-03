// ignore_for_file: overridden_fields

part of 'search_movie_cubit.dart';

abstract class SearchMovieState extends Equatable {
  final String? message;

  const SearchMovieState(this.message);

  @override
  List<Object?> get props => [message];
}

final class SearchMovieInitial extends SearchMovieState {
  const SearchMovieInitial() : super(null);
}

final class SearchMovieLoading extends SearchMovieState {
  const SearchMovieLoading() : super(null);
}

final class SearchMovieLoaded extends SearchMovieState {
  final List<MovieListEntity?> data;

  const SearchMovieLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class SearchMovieNotLoaded extends SearchMovieState {
  @override
  final String? message;

  const SearchMovieNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
