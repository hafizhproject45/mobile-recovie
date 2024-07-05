// ignore_for_file: overridden_fields

part of 'get_main_detail_cubit.dart';

abstract class GetMainDetailState extends Equatable {
  final String? message;

  const GetMainDetailState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetMainDetailInitial extends GetMainDetailState {
  const GetMainDetailInitial() : super(null);
}

final class GetMainDetailLoading extends GetMainDetailState {
  const GetMainDetailLoading() : super(null);
}

final class GetMainDetailLoaded extends GetMainDetailState {
  final MainDetailEntity? data;

  const GetMainDetailLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetMainDetailNotLoaded extends GetMainDetailState {
  @override
  final String? message;

  const GetMainDetailNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
