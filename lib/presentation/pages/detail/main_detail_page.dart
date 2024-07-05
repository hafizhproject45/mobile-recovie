import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import '../../cubit/detail_movie/get_genre/get_genre_cubit.dart';
import '../../cubit/detail_movie/get_main_detail/get_main_detail_cubit.dart';
import '../../cubit/detail_movie/get_production/get_production_cubit.dart';
import '../../cubit/detail_movie/get_credits/get_credits_cubit.dart';
import '../../cubit/detail_movie/get_teaser/get_teaser_cubit.dart';
import '../../../core/utils/colors.dart';
import '../../widgets/detail/credits_section.dart';
import '../../widgets/detail/genre_section.dart';
import '../../widgets/detail/production_section.dart';
import '../../widgets/detail/rating_section.dart';

import '../../../core/utils/text_style.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/detail_movie/get_image_poster/get_image_poster_cubit.dart';
import '../../cubit/movie_list/get_recomendations/get_recomendations_cubit.dart';
import '../../cubit/reviews/get_reviews/get_reviews_cubit.dart';
import '../../widgets/detail/carousel_section.dart';
import '../../widgets/detail/heading_section.dart';
import '../../widgets/detail/recomendations_section.dart';
import '../../widgets/detail/reviews_section.dart';
import '../../widgets/detail/teaser_section.dart';
import '../../widgets/global/my_appbar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isShowAll = false;
  int reviewsItem = 1;

  final MovieListEntity args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetMainDetailCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetImagePosterCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetReviewsCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetRecomendationsCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetTeaserCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetGenreCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetProductionCubit>()..getData(args.id),
        ),
        BlocProvider(
          create: (context) => sl<GetCreditsCubit>()..getData(args.id),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: orientation == Orientation.portrait
              ? MyAppBar(
                  isMenu: false,
                )
              : null,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? TEASER SECTION
                TeaserSection(
                  title: args.title ?? '',
                ),
                const SizedBox(height: 20),
                //? GENRE SECTION
                const GenreSection(),
                const SizedBox(height: 20),
                //? HEADING SECTION
                HeadingSection(
                  args: args,
                ),
                const SizedBox(height: 30),
                //? CAROUSEL SECTION
                const CarouselSection(),
                const SizedBox(height: 30),
                const Divider(
                  height: 5,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  width: screenWidth,
                  color: AppColor.darkCard,
                  child: Column(
                    children: [
                      //? RATING SECTION
                      RatingSection(args: args),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Divider(
                          height: 5,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //? PRODUCTION
                      const ProductionSection(),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 5,
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                //? ACTORS TEXT
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Credits',
                    style: AppTextStyle.subHeadingWhite,
                  ),
                ),
                const SizedBox(height: 20),
                //? CREDITS SECTION
                CreditsSection(
                  args: args,
                ),
                //? TEXT MORE CREDITS

                const SizedBox(height: 10),
                //? REVIEWS TEXT
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Reviews',
                    style: AppTextStyle.subHeadingWhite,
                  ),
                ),
                //? REVIEWS SECTION
                BlocBuilder<GetReviewsCubit, GetReviewsState>(
                  builder: (context, state) {
                    if (state is GetReviewsLoaded) {
                      final reviews = state.data;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReviewsSection(
                            itemCount: isShowAll
                                ? reviews.length
                                : reviews.length >= reviewsItem
                                    ? reviewsItem
                                    : reviews.length,
                          ),
                          const SizedBox(height: 20),
                          reviews.length > reviewsItem
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShowAll = !isShowAll;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      isShowAll
                                          ? 'Show Less'
                                          : 'Show All (${reviews.length - 1})',
                                      style: const TextStyle(
                                          color: AppColor.primary),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    } else if (state is GetReviewsNotLoaded) {
                      return const Center(
                        child: Text("Something Went Wrong!"),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: ShimmerCustomWidget(
                          width: screenWidth,
                          height: 300,
                          radius: BorderRadius.circular(10),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 30),
                //? RECOMENDATIONS TEXT
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Recomendations for you',
                    style: AppTextStyle.subHeadingWhite,
                  ),
                ),
                const SizedBox(height: 10),
                //? RECOMENDATIONS SECTION
                const RecomendationsSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
