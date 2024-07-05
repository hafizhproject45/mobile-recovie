import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';

import '../../../domain/entities/reviews/reviews_entity.dart';
import '../../cubit/reviews/get_reviews/get_reviews_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class ReviewsSection extends StatefulWidget {
  final int itemCount;

  const ReviewsSection({
    required this.itemCount,
    super.key,
  });

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  final int reviewsLength = 500;
  final Map<int, bool> _isExpanded = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GetReviewsCubit, GetReviewsState>(
      builder: (context, state) {
        if (state is GetReviewsLoaded) {
          final List<ReviewsEntity?> reviews = state.data;

          if (reviews.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  'Reviews not available',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              final data = reviews[index];
              if (data != null) {
                final isExpanded = _isExpanded[index] ?? false;
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    data.avatarPath != null
                                        ? '$IMAGE_URL${data.avatarPath}'
                                        : Utility.imagePlaceHolder(80, 100),
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const ShimmerCustomWidget(
                                        height: 50,
                                        width: 50,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  data.author ?? '-',
                                  style: AppTextStyle.bodyWhite,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 5,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${Utility.formatAverage(data.rating)}/10'
                                      .toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: screenWidth * 0.9,
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: AppTextStyle.bodyThin,
                            children: [
                              TextSpan(
                                text: isExpanded
                                    ? Utility.removeHtmlTags(data.content!)
                                    : Utility.removeHtmlTags(data.content!
                                            .substring(
                                                0,
                                                data.content!.length >
                                                        reviewsLength
                                                    ? reviewsLength
                                                    : data.content!.length)) +
                                        (data.content!.length > reviewsLength
                                            ? '... '
                                            : ' '),
                                style: AppTextStyle.bodyThin,
                              ),
                              if (data.content!.length > reviewsLength)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isExpanded[index] = !isExpanded;
                                      });
                                    },
                                    child: Text(
                                      isExpanded ? ' Show less' : ' Load more',
                                      style: const TextStyle(
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          maxLines: isExpanded ? null : data.content!.length,
                          overflow: isExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(
                        height: 5,
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Utility.formatDateFromString(data.createdAt ?? '-'),
                            style: AppTextStyle.mediumWhite,
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 15,
                            width: 1,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            Utility.timeAgoFormat(data.createdAt ?? '-'),
                            style: AppTextStyle.mediumWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        } else if (state is GetReviewsNotLoaded) {
          return const Center(
            child: Text("Something Went Wrong!"),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ShimmerCustomWidget(
                  width: screenWidth,
                  height: 300,
                ),
              );
            },
          );
        }
      },
    );
  }
}
