import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';

class MyCarouselSlider extends StatefulWidget {
  final VoidCallback onTap;
  final List<MovieListEntity?> movies;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const MyCarouselSlider({
    required this.onTap,
    required this.movies,
    this.onPageChanged,
    super.key,
  });

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: widget.onPageChanged,
        enableInfiniteScroll: true,
        disableCenter: true,
        autoPlayInterval: const Duration(seconds: 5),
        height: 500,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: widget.movies.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: widget.onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  width: 400,
                  movie?.posterPath != null
                      ? '$IMAGE_URL${movie?.posterPath}'
                      : 'https://via.placeholder.com/80x100.png?text=No+Image',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const ShimmerCustomWidget(
                      height: 500,
                      width: 400,
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
