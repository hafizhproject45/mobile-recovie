import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../cubit/movie_list/get_top_rated/get_top_rated_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import 'card_carousel.dart';

class TopRatedSection extends StatelessWidget {
  const TopRatedSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTopRatedCubit, GetTopRatedState>(
      builder: (context, state) {
        if (state is GetTopRatedLoaded) {
          final List<MovieListEntity?> movies = state.data;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2.1,
            ),
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
                    //? CARD IMAGE
                    CardImage(
                      image: data?.posterPath ?? '',
                    ),
                    //? CARD INFO
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      height: 150,
                      width: 175,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: AppColor.darkCard,
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
          );
        } else if (state is GetTopRatedNotLoaded) {
          return const Center(
            child: Text("Something Went Wrong!"),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              childAspectRatio: 1 / 2.3,
            ),
            itemBuilder: (context, index) {
              return ShimmerCustomWidget(
                height: 400,
                width: 175,
                radius: BorderRadius.circular(10),
              );
            },
          );
        }
      },
    );
  }
}
