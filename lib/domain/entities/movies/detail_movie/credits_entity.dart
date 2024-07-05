import 'package:equatable/equatable.dart';

class CreditsEntity extends Equatable {
  final int castId;
  final String? knownFor;
  final String? name;
  final double? popularity;
  final String? profilePath;
  final String? castFor;

  const CreditsEntity({
    required this.castId,
    this.knownFor,
    this.name,
    this.popularity,
    this.profilePath,
    this.castFor,
  });

  @override
  List<Object?> get props {
    return [
      castId,
      knownFor,
      name,
      popularity,
      profilePath,
      castFor,
    ];
  }
}
