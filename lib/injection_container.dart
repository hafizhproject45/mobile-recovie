import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'domain/usecases/movies/detail_movie/get_genre_usecase.dart';
import 'domain/usecases/movies/detail_movie/get_production_usecase.dart';
import 'presentation/cubit/detail_movie/get_genre/get_genre_cubit.dart';
import 'presentation/cubit/detail_movie/get_production/get_production_cubit.dart';
import 'data/datasources/movies/detail_movie/detail_movie_datasource.dart';
import 'data/repositories/movies/detail_movie/detail_movie_repository_impl.dart';
import 'domain/repositories/movies/detail_movie/detail_movie_repository.dart';
import 'domain/usecases/movies/detail_movie/get_credits_usecase.dart';
import 'domain/usecases/movies/detail_movie/get_main_detail_usecase.dart';
import 'domain/usecases/movies/detail_movie/get_teaser_usecase.dart';
import 'presentation/cubit/detail_movie/get_credits/get_credits_cubit.dart';
import 'presentation/cubit/detail_movie/get_main_detail/get_main_detail_cubit.dart';
import 'presentation/cubit/detail_movie/get_teaser/get_teaser_cubit.dart';
import 'data/datasources/movies/movie_list/movie_list_datasource.dart';
import 'data/datasources/movies/search_movie/search_movie_datasource.dart';
import 'data/datasources/reviews/reviews_datasource.dart';
import 'data/repositories/movies/movie_list/movie_list_repository_impl.dart';
import 'data/repositories/movies/search_movie/search_movie_repository_impl.dart';
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

final sl = GetIt.instance;

Future<void> initLocator() async {
  sl.allowReassignment = true;

  ///////////////
  //! External
  ///////////////
// Dio
  sl.registerSingleton(
    Dio(
      BaseOptions(
        baseUrl: BASE_URL,
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

  //? Main Detail
  sl.registerFactory(
    () => GetMainDetailCubit(getMainDetailUseCase: sl()),
  );

  //? Image Poster
  sl.registerFactory(
    () => GetImagePosterCubit(getImagePosterUseCase: sl()),
  );

  //? Teaser
  sl.registerFactory(
    () => GetTeaserCubit(getTeaserUseCase: sl()),
  );

  //? Genre
  sl.registerFactory(
    () => GetGenreCubit(getGenreUseCase: sl()),
  );

  //? Production
  sl.registerFactory(
    () => GetProductionCubit(getProductionUseCase: sl()),
  );

  //? Credits
  sl.registerFactory(
    () => GetCreditsCubit(getCreditsUseCase: sl()),
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

  //? Main Detail
  sl.registerLazySingleton(
      () => GetMainDetailUseCase(detailMovieRepository: sl()));

  //? Image Poster
  sl.registerLazySingleton(
      () => GetImagePosterUseCase(detailMovieRepository: sl()));

  //? Teaser
  sl.registerLazySingleton(() => GetTeaserUseCase(detailMovieRepository: sl()));

  //? Genre
  sl.registerLazySingleton(() => GetGenreUseCase(detailMovieRepository: sl()));

  //? Production
  sl.registerLazySingleton(
      () => GetProductionUseCase(detailMovieRepository: sl()));

  //? Credits
  sl.registerLazySingleton(
      () => GetCreditsUseCase(detailMovieRepository: sl()));

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

  //? Detail Movie
  sl.registerLazySingleton<DetailMovieRepository>(
    () => DetailMovieRepositoryImpl(detailMovieDataSource: sl()),
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

  //? Detail Movie
  sl.registerLazySingleton<DetailMovieDataSource>(
    () => DetailMovieDataSourceImpl(baseApi: sl()),
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
