import 'package:equatable/equatable.dart';

class TeaserEntity extends Equatable {
  final String id;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;

  const TeaserEntity({
    required this.id,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      key,
      site,
      size,
      type,
      official,
      publishedAt,
    ];
  }
}
