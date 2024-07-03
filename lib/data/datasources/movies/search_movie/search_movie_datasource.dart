// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dio/dio.dart';
import '../../../../core/utils/constants.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../services/base_api.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/env.dart';
import '../../../models/movies/movie_list/movie_list_model.dart';

abstract class SearchMovieDataSource {
  Future<List<MovieListEntity>> searchMovie(String params);
}

class SearchMovieDataSourceImpl extends SearchMovieDataSource {
  final BaseApi baseApi;

  SearchMovieDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<MovieListEntity>> searchMovie(String params) async {
    try {
      final res = await baseApi.get(SEARCH_MOVIE, queryParameters: {
        'api_key': Env.apiKeyAuth,
        'query': params,
      });

      if (res.statusCode == 200) {
        List<MovieListEntity> data = (res.data['results'] as List)
            .map((x) => MovieListModel.fromJson(x))
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
