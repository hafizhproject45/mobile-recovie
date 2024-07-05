import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String? name;

  const GenreEntity({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}
