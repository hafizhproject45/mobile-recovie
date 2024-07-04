// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dio/dio.dart';
import '../../../../domain/entities/movies/detail_movie/teaser_entity.dart';
import '../../../../services/base_api.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/env.dart';
import '../../../models/movies/detail_movie/teaser_model.dart';

abstract class TeaserDataSource {
  Future<List<TeaserEntity>> getTeaser(int movieId);
}

class TeaserDataSourceImpl extends TeaserDataSource {
  final BaseApi baseApi;

  TeaserDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<TeaserEntity>> getTeaser(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId/videos',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        List<TeaserEntity> data = (res.data['results'] as List)
            .map((x) => TeaserModel.fromJson(x))
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
