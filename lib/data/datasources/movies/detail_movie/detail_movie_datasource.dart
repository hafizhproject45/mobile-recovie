// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:recovie/data/models/movies/detail_movie/credits_model.dart';
import 'package:recovie/data/models/movies/detail_movie/genre_model.dart';
import 'package:recovie/data/models/movies/detail_movie/main_detail_model.dart';
import 'package:recovie/data/models/movies/detail_movie/production_model.dart';
import 'package:recovie/domain/entities/movies/detail_movie/credits_entity.dart';
import 'package:recovie/domain/entities/movies/detail_movie/main_detail_entity.dart';
import 'package:recovie/services/base_api.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/env.dart';
import '../../../../domain/entities/movies/detail_movie/genre_entity.dart';
import '../../../../domain/entities/movies/detail_movie/image_poster_entity.dart';
import '../../../../domain/entities/movies/detail_movie/production_entity.dart';
import '../../../../domain/entities/movies/detail_movie/teaser_entity.dart';
import '../../../models/movies/detail_movie/image_poster_model.dart';
import '../../../models/movies/detail_movie/teaser_model.dart';

abstract class DetailMovieDataSource {
  Future<MainDetailEntity> getMainDetail(int movieId);
  Future<List<ImagePosterEntity>> getImagePoster(int movieId);
  Future<List<TeaserEntity>> getTeaser(int movieId);
  Future<List<CreditsEntity>> getCredits(int movieId);
  Future<List<GenreEntity>> getGenre(int movieId);
  Future<List<ProductionEntity>> getProduction(int movieId);
}

class DetailMovieDataSourceImpl extends DetailMovieDataSource {
  final BaseApi baseApi;

  DetailMovieDataSourceImpl({
    required this.baseApi,
  });

  @override
  Future<List<CreditsEntity>> getCredits(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId/credits',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        List<CreditsEntity> data = (res.data['cast'] as List)
            .map((x) => CreditsModel.fromJson(x))
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
  Future<List<ImagePosterEntity>> getImagePoster(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId/images',
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

  @override
  Future<MainDetailEntity> getMainDetail(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        return MainDetailModel.fromJson(res.data);
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
  Future<List<GenreEntity>> getGenre(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        List<GenreEntity> data = (res.data['genres'] as List)
            .map((x) => GenreModel.fromJson(x))
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
  Future<List<ProductionEntity>> getProduction(int movieId) async {
    try {
      final res = await baseApi.get(
        '$MOVIE$movieId',
        queryParameters: {
          'api_key': Env.apiKeyAuth,
        },
      );

      if (res.statusCode == 200) {
        List<ProductionEntity> data = (res.data['production_companies'] as List)
            .map((x) => ProductionModel.fromJson(x))
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
