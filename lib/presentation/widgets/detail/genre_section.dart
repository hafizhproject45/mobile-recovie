import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/colors.dart';
import '../../../domain/entities/movies/detail_movie/genre_entity.dart';
import '../../cubit/detail_movie/get_genre/get_genre_cubit.dart';

import '../global/shimmer/my_shimmer_custom.dart';

class GenreSection extends StatefulWidget {
  const GenreSection({super.key});

  @override
  State<GenreSection> createState() => _GenreSectionState();
}

class _GenreSectionState extends State<GenreSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GetGenreCubit, GetGenreState>(
      builder: (context, state) {
        if (state is GetGenreLoaded) {
          final List<GenreEntity?> genre = state.data;

          return SizedBox(
            width: screenWidth,
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: genre.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final data = genre[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.darkCard,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(child: Text('#${data?.name}')),
                  ),
                );
              },
            ),
          );
        } else if (state is GetGenreNotLoaded) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return SizedBox(
            width: screenWidth,
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              itemCount: 3,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(5),
                    child: ShimmerCustomWidget(
                      width: 100,
                      height: 50,
                      radius: BorderRadius.circular(5),
                    ));
              },
            ),
          );
        }
      },
    );
  }
}
