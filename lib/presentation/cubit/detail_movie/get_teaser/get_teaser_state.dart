// ignore_for_file: overridden_fields

part of 'get_teaser_cubit.dart';

abstract class GetTeaserState extends Equatable {
  final String? message;

  const GetTeaserState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetTeaserInitial extends GetTeaserState {
  const GetTeaserInitial() : super(null);
}

final class GetTeaserLoading extends GetTeaserState {
  const GetTeaserLoading() : super(null);
}

final class GetTeaserLoaded extends GetTeaserState {
  final List<TeaserEntity?> data;

  const GetTeaserLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetTeaserNotLoaded extends GetTeaserState {
  @override
  final String? message;

  const GetTeaserNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
