// ignore_for_file: overridden_fields

part of 'get_credits_cubit.dart';

abstract class GetCreditsState extends Equatable {
  final String? message;

  const GetCreditsState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetCreditsInitial extends GetCreditsState {
  const GetCreditsInitial() : super(null);
}

final class GetCreditsLoading extends GetCreditsState {
  const GetCreditsLoading() : super(null);
}

final class GetCreditsLoaded extends GetCreditsState {
  final List<CreditsEntity?> data;

  const GetCreditsLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetCreditsNotLoaded extends GetCreditsState {
  @override
  final String? message;

  const GetCreditsNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
