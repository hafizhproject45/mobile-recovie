import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'data/datasources/movies/detail_movie/image_poster_datasource.dart';
import 'data/datasources/movies/movie_list/movie_list_datasource.dart';
import 'data/datasources/movies/search_movie/search_movie_datasource.dart';
import 'data/datasources/reviews/reviews_datasource.dart';
import 'data/repositories/movies/detail_movie/image_poster_repository_impl.dart';
import 'data/repositories/movies/movie_list/movie_list_repository_impl.dart';
import 'data/repositories/movies/search_movie/search_movie_repository_impl.dart';
import 'domain/repositories/movies/detail_movie/image_poster_repository.dart';
import 'domain/repositories/movies/movie_list/movie_list_repository.dart';
import 'domain/repositories/movies/search_movie/search_movie_repository.dart';
import 'domain/repositories/reviews/reviews_repository.dart';
import 'domain/usecases/movies/detail_movie/get_image_poster_usecase.dart';
import 'domain/usecases/movies/movie_list/get_now_playing_usecase.dart';
import 'domain/usecases/movies/movie_list/get_popular_usecase.dart';
import 'domain/usecases/movies/movie_list/get_top_rated_usecase.dart';
import 'domain/usecases/movies/movie_list/get_upcoming_usecase.dart';
import 'domain/usecases/movies/search_movie/search_movie_usecase.dart';
import 'domain/usecases/reviews/get_reviews_usecase.dart';
import 'presentation/cubit/detail_movie/get_image_poster/get_image_poster_cubit.dart';
import 'presentation/cubit/movie_list/get_now_playing/get_now_playing_cubit.dart';
import 'presentation/cubit/movie_list/get_popular/get_popular_cubit.dart';
import 'presentation/cubit/movie_list/get_top_rated/get_top_rated_cubit.dart';
import 'presentation/cubit/movie_list/get_upcoming/get_upcoming_cubit.dart';
import 'presentation/cubit/reviews/get_reviews/get_reviews_cubit.dart';
import 'presentation/cubit/search_movie/search_movie_cubit.dart';

import 'core/utils/constants.dart';
import 'data/repositories/reviews/reviews_repository_impl.dart';
import 'domain/usecases/movies/movie_list/get_recomendations_usecase.dart';
import 'domain/usecases/movies/movie_list/get_trending_usecase.dart';
import 'presentation/cubit/movie_list/get_recomendations/get_recomendations_cubit.dart';
import 'presentation/cubit/movie_list/get_trending/get_trending_cubit.dart';
import 'services/base_api.dart';

var sl = GetIt.instance;

Future<void> initLocator() async {
  sl.allowReassignment = true;

  ///////////////
  //! External
  ///////////////
// Dio
  sl.registerSingleton(
    Dio(
      BaseOptions(
        baseUrl: '$BASE_URL/api/',
      ),
    )
      ..options.headers['Accept'] = 'application/json'
      ..options.headers['Content-Type'] = 'application/json'
      ..interceptors.addAll([
        if (kDebugMode)
          PrettyDioLogger(
            request: kDebugMode,
            requestHeader: kDebugMode,
            responseHeader: kDebugMode,
            responseBody: kDebugMode,
          ),
      ]),
  );
  sl.registerSingleton(
    BaseApi(sl()),
  );

  ///////////////
  ///! Bloc / Cubit
  ///////////////

  //? Movie List
  sl.registerFactory(
    () => GetNowPlayingCubit(getNowPlayingUseCase: sl()),
  );
  sl.registerFactory(
    () => GetPopularCubit(getPopularUseCase: sl()),
  );
  sl.registerFactory(
    () => GetTopRatedCubit(getTopRatedUseCase: sl()),
  );
  sl.registerFactory(
    () => GetUpcomingCubit(getUpComingUseCase: sl()),
  );
  sl.registerFactory(
    () => GetTrendingCubit(getTrendingUseCase: sl()),
  );
  sl.registerFactory(
    () => GetRecomendationsCubit(getRecomendationsUseCase: sl()),
  );

  //? Image Poster
  sl.registerFactory(
    () => GetImagePosterCubit(getImagePosterUseCase: sl()),
  );

  //? Search Movie
  sl.registerFactory(
    () => SearchMovieCubit(searchMovieUseCase: sl()),
  );

  //? Reviews
  sl.registerFactory(
    () => GetReviewsCubit(getReviewsUseCase: sl()),
  );

  ///////////////
  //! Usecase
  ///////////////

  //? Movie List
  sl.registerLazySingleton(
      () => GetNowPlayingUseCase(movieListRepository: sl()));
  sl.registerLazySingleton(() => GetPopularUseCase(movieListRepository: sl()));
  sl.registerLazySingleton(() => GetTopRatedUseCase(movieListRepository: sl()));
  sl.registerLazySingleton(() => GetUpComingUseCase(movieListRepository: sl()));
  sl.registerLazySingleton(() => GetTrendingUseCase(movieListRepository: sl()));
  sl.registerLazySingleton(
      () => GetRecomendationsUseCase(movieListRepository: sl()));

  //? Image Poster
  sl.registerLazySingleton(
      () => GetImagePosterUseCase(imagePosterRepository: sl()));

  //? Search Movie
  sl.registerLazySingleton(
      () => SearchMovieUseCase(searchMovieRepository: sl()));

  //? Reviews
  sl.registerLazySingleton(() => GetReviewsUseCase(reviewsRepository: sl()));

  ///////////////
  //! Repository
  ///////////////

  //? Movie List
  sl.registerLazySingleton<MovieListRepository>(
    () => MovieListReposisoryImpl(movieListDataSource: sl()),
  );

  //? Movie List
  sl.registerLazySingleton<ImagePosterRepository>(
    () => ImagePosterRepositoryImpl(imagePosterDataSource: sl()),
  );

  //? Search List
  sl.registerLazySingleton<SearchMovieRepository>(
    () => SearchMovieRepositoryImpl(searchMovieDataSource: sl()),
  );

  //? Reviews
  sl.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(reviewsDataSource: sl()),
  );

  ///////////////
  //! DataSource
  ///////////////

  //? Movie List
  sl.registerLazySingleton<MovieListDataSource>(
    () => MovieListDataSourceImpl(baseApi: sl()),
  );

  //? Movie List
  sl.registerLazySingleton<ImagePosterDataSource>(
    () => ImagePosterDataSourceImpl(baseApi: sl()),
  );

  //? Search Movie
  sl.registerLazySingleton<SearchMovieDataSource>(
    () => SearchMovieDataSourceImpl(baseApi: sl()),
  );

  //? Reviews
  sl.registerLazySingleton<ReviewsDataSource>(
    () => ReviewsDataSourceImpl(baseApi: sl()),
  );
}
