import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../global/shimmer/my_shimmer_custom.dart';

import '../../../domain/entities/movies/detail_movie/image_poster_entity.dart';

class DetailSlider extends StatefulWidget {
  final List<ImagePosterEntity?> movies;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const DetailSlider({
    required this.movies,
    this.onPageChanged,
    super.key,
  });

  @override
  State<DetailSlider> createState() => _DetailSliderState();
}

class _DetailSliderState extends State<DetailSlider> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 5),
        autoPlay: true,
        onPageChanged: widget.onPageChanged,
        enableInfiniteScroll: true,
        disableCenter: true,
        aspectRatio: screenWidth / 200,
        enlargeCenterPage: true,
      ),
      items: widget.movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return InstaImageViewer(
              imageUrl: '$IMAGE_URL${movie?.filePath}',
              backgroundColor: AppColor.background,
              disableSwipeToDismiss: true,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '$IMAGE_URL${movie?.filePath}',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ShimmerCustomWidget(
                      width: screenWidth,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
