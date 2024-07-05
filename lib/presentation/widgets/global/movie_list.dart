import 'package:flutter/material.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/utility.dart';
import '../../../core/utils/text_style.dart';
import 'shimmer/my_shimmer_custom.dart';

class MovieList extends StatelessWidget {
  final String title;
  final String oriTitle;
  final String rating;
  final String desc;
  final String release;
  final String image;
  final VoidCallback onTap;

  const MovieList({
    required this.title,
    required this.oriTitle,
    required this.rating,
    required this.desc,
    required this.release,
    required this.image,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    image.isEmpty || image == ''
                        ? Utility.imagePlaceHolder(80, 100)
                        : '$IMAGE_URL$image',
                    height: 100,
                    width: 80,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ShimmerCustomWidget(
                        height: 100,
                        width: 80,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text('$rating/10'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenWidth * 0.7,
                      child: Text(
                        title,
                        style: AppTextStyle.bodyWhite,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    title != oriTitle
                        ? SizedBox(
                            width: screenWidth * 0.7,
                            child: Text(
                              oriTitle,
                              style: AppTextStyle.bodyWhite,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Text(
                        desc,
                        style: AppTextStyle.mediumWhite,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Text(
                        'Release: ${Utility.formatDateFromString(release)}',
                        maxLines: 1,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 5,
            thickness: 0.5,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
