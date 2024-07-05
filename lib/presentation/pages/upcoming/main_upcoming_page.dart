import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/movie_list/get_upcoming/get_upcoming_cubit.dart';
import '../../widgets/global/movie_list.dart';
import '../../widgets/global/my_appbar.dart';
import '../../widgets/global/my_drawer.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  final upcomingCubit = sl<GetUpcomingCubit>();
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => upcomingCubit..getData(),
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: BlocBuilder<GetUpcomingCubit, GetUpcomingState>(
        builder: (context, state) {
          if (state is GetUpcomingLoaded) {
            final List<MovieListEntity?> movie = state.data;

            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () => _onRefresh(context),
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: movie.length,
                itemBuilder: (context, index) {
                  final data = movie[index];
                  return MovieList(
                    title: data?.title ?? '-',
                    oriTitle: data?.oriTitle ?? '-',
                    rating: Utility.formatAverage(data?.voteAverage).toString(),
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
                        voteAverage: Utility.formatAverage(data.voteAverage),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is GetUpcomingNotLoaded) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () => _onRefresh(context),
              child: const Center(
                child: Text("Something Went Wrong!"),
              ),
            );
          } else {
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
          }
        },
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    upcomingCubit.getData();
    _refreshController.refreshCompleted();
  }
}
