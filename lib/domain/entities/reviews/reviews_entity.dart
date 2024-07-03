// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ReviewsEntity extends Equatable {
  final String? author;
  final String? avatarPath;
  final double? rating;
  final String? content;
  final String? createdAt;

  const ReviewsEntity({
    this.author,
    this.avatarPath,
    this.rating,
    this.content,
    this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      author,
      avatarPath,
      rating,
      content,
      createdAt,
    ];
  }
}
