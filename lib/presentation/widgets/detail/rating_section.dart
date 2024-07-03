import 'package:flutter/material.dart';
import '../../../core/utils/utility.dart';

import '../../../core/utils/text_style.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';

class RatingSection extends StatelessWidget {
  final MovieListEntity args;

  const RatingSection({
    required this.args,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 30,
            ),
            Text(
              '${args.voteAverage}/10',
              style: AppTextStyle.body,
            ),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          children: [
            Text(
              Utility.formatNumberWithDots(args.voteCount ?? 0),
              style: AppTextStyle.subHeadingWhite,
            ),
            const SizedBox(height: 5),
            const Text(
              'Vote Count',
              style: AppTextStyle.bodyWhite,
            ),
          ],
        ),
      ],
    );
  }
}
