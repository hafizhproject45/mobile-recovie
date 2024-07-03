// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dio/dio.dart';
import '../../../../data/models/movies/detail_movie/image_poster.dart';
import '../../../../domain/entities/movies/detail_movie/image_poster_entity.dart';
import '../../../../services/base_api.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/env.dart';

abstract class ImagePosterDataSource {
  Future<List<ImagePosterEntity>> getImagePoster(int movieId);
}

class ImagePosterDataSourceImpl extends ImagePosterDataSource {
  final BaseApi baseApi;

  ImagePosterDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<ImagePosterEntity>> getImagePoster(int movieId) async {
    try {
      final res = await baseApi.get(
        '$IMAGE_POSTER$movieId/images',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        List<ImagePosterEntity> data = (res.data['backdrops'] as List)
            .map((x) => ImagePosterModel.fromJson(x))
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
