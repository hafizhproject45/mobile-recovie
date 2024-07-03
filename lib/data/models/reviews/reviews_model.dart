import '../../../domain/entities/reviews/reviews_entity.dart';

class ReviewsModel extends ReviewsEntity {
  const ReviewsModel({
    super.author,
    super.avatarPath,
    super.rating,
    super.content,
    super.createdAt,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      author: json['author'],
      avatarPath: json['author_details']['avatar_path'],
      rating: json['author_details']['rating'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}
