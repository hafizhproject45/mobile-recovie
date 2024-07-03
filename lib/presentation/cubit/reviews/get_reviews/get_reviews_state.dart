// ignore_for_file: overridden_fields

part of 'get_reviews_cubit.dart';

abstract class GetReviewsState extends Equatable {
  final String? message;

  const GetReviewsState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetReviewsInitial extends GetReviewsState {
  const GetReviewsInitial() : super(null);
}

final class GetReviewsLoading extends GetReviewsState {
  const GetReviewsLoading() : super(null);
}

final class GetReviewsLoaded extends GetReviewsState {
  final List<ReviewsEntity?> data;

  const GetReviewsLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetReviewsNotLoaded extends GetReviewsState {
  @override
  final String? message;

  const GetReviewsNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
