import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class HeadingSection extends StatelessWidget {
  const HeadingSection({
    super.key,
    required this.args,
  });

  final MovieListEntity args;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            args.title!,
            style: AppTextStyle.headingWhite,
          ),
          args.title != args.oriTitle
              ? Text(
                  args.oriTitle!,
                  style: AppTextStyle.bodyWhite,
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Release: ${Utility.formatDateFromString(args.releaseDate!)}',
                style: AppTextStyle.mediumWhite,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InstaImageViewer(
                imageUrl: args.posterPath != '' || args.posterPath!.isNotEmpty
                    ? '$IMAGE_URL${args.posterPath}'
                    : IMAGE_PLACEHOLDER,
                backgroundColor: AppColor.background,
                disableSwipeToDismiss: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    args.posterPath != '' || args.posterPath!.isNotEmpty
                        ? '$IMAGE_URL${args.posterPath}'
                        : IMAGE_PLACEHOLDER,
                    height: 160,
                    width: 120,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ShimmerCustomWidget(
                        height: 120,
                        width: 100,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: screenWidth * 0.55,
                child: Text(
                  args.overview!,
                  style: AppTextStyle.medium,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
