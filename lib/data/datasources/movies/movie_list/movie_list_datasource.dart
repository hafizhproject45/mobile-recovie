// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:dio/dio.dart';
import '../../../../data/models/movies/movie_list/movie_list_model.dart';
import '../../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../../services/base_api.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/env.dart';

abstract class MovieListDataSource {
  Future<List<MovieListEntity>> getPopuluarMovieList();
  Future<List<MovieListEntity>> getNowPlayingMovieList();
  Future<List<MovieListEntity>> getTopRatedMovieList();
  Future<List<MovieListEntity>> getUpComingMovieList();
  Future<List<MovieListEntity>> getTrendingMovieList();
  Future<List<MovieListEntity>> getRecomendationsMovieList(int movieId);
}

class MovieListDataSourceImpl extends MovieListDataSource {
  final BaseApi baseApi;

  MovieListDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<MovieListEntity>> getNowPlayingMovieList() async {
    try {
      final res = await baseApi.get(NOW_PLAYING_LIST, queryParameters: {
        'api_key': Env.apiKeyAuth,
        // 'language': 'id-ID, en-US',
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

  @override
  Future<List<MovieListEntity>> getTopRatedMovieList() async {
    try {
      final res = await baseApi.get(TOP_RATED_LIST, queryParameters: {
        'api_key': Env.apiKeyAuth,
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

  @override
  Future<List<MovieListEntity>> getPopuluarMovieList() async {
    try {
      final res = await baseApi.get(POPULAR_LIST, queryParameters: {
        'api_key': Env.apiKeyAuth,
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

  @override
  Future<List<MovieListEntity>> getUpComingMovieList() async {
    try {
      final res = await baseApi.get(UPCOMING_LIST, queryParameters: {
        'api_key': Env.apiKeyAuth,
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

  @override
  Future<List<MovieListEntity>> getTrendingMovieList() async {
    try {
      final res = await baseApi.get(TRENDING_LIST, queryParameters: {
        'api_key': Env.apiKeyAuth,
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

  @override
  Future<List<MovieListEntity>> getRecomendationsMovieList(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId/recommendations',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

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
