// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class MainDetailEntity extends Equatable {
  final bool? adult;
  final String? name;
  final int? budget;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;

  const MainDetailEntity({
    this.adult,
    this.name,
    this.budget,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
  });

  @override
  List<Object?> get props {
    return [
      adult,
      name,
      budget,
      revenue,
      runtime,
      status,
      tagline,
    ];
  }
}
