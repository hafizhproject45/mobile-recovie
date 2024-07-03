import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../cubit/movie_list/get_recomendations/get_recomendations_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import '../home/card_carousel.dart';

class RecomendationsSection extends StatelessWidget {
  const RecomendationsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRecomendationsCubit, GetRecomendationsState>(
      builder: (context, state) {
        if (state is GetRecomendationsLoaded) {
          final List<MovieListEntity?> movies = state.data;

          return SizedBox(
            width: double.infinity,
            height: 450,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final data = movies[index];

                return GestureDetector(
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
                  child: Column(
                    children: [
                      CardCarousel(
                        image: data?.posterPath ?? '',
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        height: 150,
                        width: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5)),
                          color: Color.fromARGB(255, 52, 52, 52),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${Utility.formatAverage(data?.voteAverage)}/10'
                                      .toString(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data?.title ?? '-',
                              style: AppTextStyle.body,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Release:\n${Utility.formatDateFromString(data?.releaseDate ?? '-')}',
                                style: AppTextStyle.mediumWhite,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is GetRecomendationsNotLoaded) {
          return const Center(
            child: Text("Something Went Wrong!"),
          );
        } else {
          return Center(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ShimmerCustomWidget(
                      radius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      height: 200,
                      width: 150,
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
