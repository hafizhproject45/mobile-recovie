import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import '../../../core/utils/colors.dart';
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
import '../../widgets/global/my_appbar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isShowAll = false;

  final posterCubit = sl<GetImagePosterCubit>();
  final reviewsCubit = sl<GetReviewsCubit>();
  final recomendationsCubit = sl<GetRecomendationsCubit>();

  final MovieListEntity args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => posterCubit..getData(args.id),
        ),
        BlocProvider(
          create: (context) => recomendationsCubit..getData(args.id),
        ),
        BlocProvider(
          create: (context) => reviewsCubit..getData(args.id),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        isMenu: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingSection(
              args: args,
            ),
            const SizedBox(height: 30),
            const CarouselSection(),
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 10),
            RatingSection(args: args),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Reviews',
                style: AppTextStyle.subHeadingWhite,
              ),
            ),
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
                            : reviews.length >= 3
                                ? 3
                                : reviews.length,
                      ),
                      const SizedBox(height: 20),
                      reviews.length > 3
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isShowAll = !isShowAll;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  isShowAll
                                      ? 'Show Less (3)'
                                      : 'Show All (${reviews.length})',
                                  style:
                                      const TextStyle(color: AppColor.primary),
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
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Recomendations for you',
                style: AppTextStyle.subHeadingWhite,
              ),
            ),
            const SizedBox(height: 10),
            const RecomendationsSection(),
          ],
        ),
      ),
    );
  }
}
