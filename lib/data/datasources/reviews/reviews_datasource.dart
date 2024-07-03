// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dio/dio.dart';
import '../../../data/models/reviews/reviews_model.dart';
import '../../../domain/entities/reviews/reviews_entity.dart';
import '../../../services/base_api.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/env.dart';

abstract class ReviewsDataSource {
  Future<List<ReviewsEntity>> getReviews(int movieId);
}

class ReviewsDataSourceImpl extends ReviewsDataSource {
  final BaseApi baseApi;

  ReviewsDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<ReviewsEntity>> getReviews(int movieId) async {
    try {
      final res = await baseApi.get('$MOVIE$movieId/reviews', queryParameters: {
        'api_key': Env.apiKeyAuth,
      });

      if (res.statusCode == 200) {
        List<ReviewsEntity> data = (res.data['results'] as List)
            .map((x) => ReviewsModel.fromJson(x))
            .toList();

        return data;
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is DioError) {
        throw ServerException(message: e.message);
      } else if (e is ServerException) {
        rethrow;
      } else {
        throw UnknownException();
      }
    }
  }
}
