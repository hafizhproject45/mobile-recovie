import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/movie_list/get_popular/get_popular_cubit.dart';
import '../../cubit/movie_list/get_top_rated/get_top_rated_cubit.dart';
import '../../widgets/global/my_appbar.dart';
import '../../widgets/global/my_drawer.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/home/my_carousel_slider.dart';
import '../../widgets/home/top_rated_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final popularCubit = sl<GetPopularCubit>();
  final topRatedCubit = sl<GetTopRatedCubit>();
  final RefreshController _refreshController = RefreshController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => popularCubit..getData(),
        ),
        BlocProvider(
          create: (context) => topRatedCubit..getData(),
        ),
      ],
      child: _content(),
    );
  }

  Scaffold _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => _onRefresh(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? POPULAR TEXT ()
                const Center(
                  child: Text(
                    'Popular Movies',
                    style: AppTextStyle.headingWhite,
                  ),
                ),
                const SizedBox(height: 30),
                //? TOP RATED SECTION
                BlocBuilder<GetPopularCubit, GetPopularState>(
                  builder: (context, state) {
                    if (state is GetPopularLoaded) {
                      final List<MovieListEntity?> movies = state.data;
                      final data = movies[_currentIndex];

                      return Column(
                        children: [
                          //? TOP RATED SECTION (CAROUSEL)
                          MyCarouselSlider(
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
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
                            movies: movies,
                          ),
                        ],
                      );
                    } else if (state is GetPopularNotLoaded) {
                      return const Center(
                        child: Text("Something Went Wrong!"),
                      );
                    } else {
                      return Center(
                        child: ShimmerCustomWidget(
                          radius: BorderRadius.circular(10),
                          height: 500,
                          width: screenWidth * 0.8,
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 40),
                //? TOP RATED TEXT
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Top Rated',
                    style: AppTextStyle.headingWhite,
                  ),
                ),
                const SizedBox(height: 10),
                //? TOP RATED SECTION
                const TopRatedSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    popularCubit.getData();
    topRatedCubit.getData();
    _refreshController.refreshCompleted();
  }
}
