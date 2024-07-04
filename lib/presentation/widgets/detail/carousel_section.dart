// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/movies/detail_movie/image_poster_entity.dart';
import '../../cubit/detail_movie/get_image_poster/get_image_poster_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import 'detail_slider.dart';

class CarouselSection extends StatefulWidget {
  const CarouselSection({super.key});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GetImagePosterCubit, GetImagePosterState>(
      builder: (context, state) {
        if (state is GetImagePosterLoaded) {
          final List<ImagePosterEntity?> movies = state.data;

          if (movies.isEmpty) {
            return Center(
              child: Container(
                height: 200,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.shimmerHighlight,
                ),
                child: const Center(
                  child: Text(
                    'Image not available',
                    style: AppTextStyle.medium,
                  ),
                ),
              ),
            );
          }

          return DetailSlider(
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            movies: movies,
          );
        } else if (state is GetImagePosterNotLoaded) {
          return const Center(
            child: Text('Image not found'),
          );
        } else if (state is GetImagePosterLoading) {
          return Center(
            child: ShimmerCustomWidget(
              height: 200,
              width: screenWidth * 0.95,
              radius: BorderRadius.circular(10),
            ),
          );
        } else {
          return const Center(
            child: Text("Something Went Wrong!"),
          );
        }
      },
    );
  }
}
