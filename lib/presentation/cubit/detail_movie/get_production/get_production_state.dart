// ignore_for_file: overridden_fields

part of 'get_production_cubit.dart';

abstract class GetProductionState extends Equatable {
  final String? message;

  const GetProductionState(this.message);

  @override
  List<Object?> get props => [message];
}

final class GetProductionInitial extends GetProductionState {
  const GetProductionInitial() : super(null);
}

final class GetProductionLoading extends GetProductionState {
  const GetProductionLoading() : super(null);
}

final class GetProductionLoaded extends GetProductionState {
  final List<ProductionEntity?> data;

  const GetProductionLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

final class GetProductionNotLoaded extends GetProductionState {
  @override
  final String? message;

  const GetProductionNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
