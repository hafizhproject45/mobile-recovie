import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../cubit/movie_list/get_trending/get_trending_cubit.dart';
import '../../cubit/search_movie/search_movie_cubit.dart';
import '../global/movie_list.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class SearchField extends StatelessWidget {
  final TextEditingController _searchController;

  const SearchField({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: BlocBuilder<SearchMovieCubit, SearchMovieState>(
        builder: (context, state) {
          if (_searchController.text.trim().isEmpty) {
            return BlocBuilder<GetTrendingCubit, GetTrendingState>(
              builder: (context, state) {
                if (state is GetTrendingLoaded) {
                  final List<MovieListEntity?> movie = state.data;

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: movie.length,
                    itemBuilder: (context, index) {
                      final data = movie[index];
                      return MovieList(
                        title: data?.title ?? '-',
                        oriTitle: data?.oriTitle ?? '-',
                        rating:
                            Utility.formatAverage(data?.voteAverage).toString(),
                        desc: data?.overview ?? '-',
                        release: data?.releaseDate ?? '-',
                        image: data?.posterPath ?? '',
                        onTap: () => Get.toNamed(
                          '/detail/${data!.id}',
                          arguments: MovieListEntity(
                            id: data.id,
                            title: data.title ?? '-',
                            oriTitle: data.oriTitle ?? '-',
                            overview: data.overview ?? '-',
                            posterPath: data.posterPath ?? '',
                            releaseDate: data.releaseDate ?? '-',
                            voteCount: data.voteCount ?? 0,
                            voteAverage:
                                Utility.formatAverage(data.voteAverage),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is GetTrendingNotLoaded) {
                  return Center(
                    child: Text(state.message!),
                  );
                } else if (state is GetTrendingLoading) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ShimmerCustomWidget(
                                radius: BorderRadius.circular(5),
                                height: 100,
                                width: 80,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShimmerCustomWidget(
                                    height: 20,
                                    width: screenWidth * 0.1,
                                  ),
                                  const SizedBox(height: 5),
                                  ShimmerCustomWidget(
                                    height: 20,
                                    width: screenWidth * 0.5,
                                  ),
                                  const SizedBox(height: 5),
                                  ShimmerCustomWidget(
                                    height: 40,
                                    width: screenWidth * 0.6,
                                  ),
                                  const SizedBox(height: 5),
                                  ShimmerCustomWidget(
                                    height: 20,
                                    width: screenWidth * 0.4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider()
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Movies not loaded'));
                }
              },
            );
          }

          if (state is SearchMovieLoaded) {
            final List<MovieListEntity?> movie = state.data;

            if (movie.isEmpty) {
              return const Column(
                children: [
                  SizedBox(height: 30),
                  Text('Movie not found'),
                ],
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: movie.length,
              itemBuilder: (context, index) {
                final data = movie[index];
                if (data != null) {
                  return MovieList(
                    title: data.title ?? '-',
                    oriTitle: data.oriTitle ?? '-',
                    rating: Utility.formatAverage(data.voteAverage).toString(),
                    desc: data.overview ?? '-',
                    release: data.releaseDate ?? '-',
                    image: data.posterPath ?? '',
                    onTap: () => Get.toNamed(
                      '/detail/${data.id}',
                      arguments: MovieListEntity(
                        id: data.id,
                        title: data.title ?? '-',
                        oriTitle: data.oriTitle ?? '-',
                        overview: data.overview ?? '-',
                        posterPath: data.posterPath ?? '',
                        releaseDate: data.releaseDate ?? '-',
                        voteCount: data.voteCount ?? 0,
                        voteAverage: Utility.formatAverage(data.voteAverage),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          } else if (state is SearchMovieLoading) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        ShimmerCustomWidget(
                          radius: BorderRadius.circular(5),
                          height: 100,
                          width: 80,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShimmerCustomWidget(
                              height: 20,
                              width: screenWidth * 0.1,
                            ),
                            const SizedBox(height: 5),
                            ShimmerCustomWidget(
                              height: 20,
                              width: screenWidth * 0.5,
                            ),
                            const SizedBox(height: 5),
                            ShimmerCustomWidget(
                              height: 40,
                              width: screenWidth * 0.6,
                            ),
                            const SizedBox(height: 5),
                            ShimmerCustomWidget(
                              height: 20,
                              width: screenWidth * 0.4,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider()
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: Text("Something Went Wrong!"),
            );
          }
        },
      ),
    );
  }
}
