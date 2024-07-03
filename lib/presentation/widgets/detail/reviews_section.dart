import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/entities/reviews/reviews_entity.dart';
import '../../cubit/reviews/get_reviews/get_reviews_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class ReviewsSection extends StatelessWidget {
  final int itemCount;

  const ReviewsSection({
    required this.itemCount,
    super.key,
  });

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
                child: Text('No reviews available'),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final data = reviews[index];
              if (data != null) {
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
                                        : IMAGE_PLACEHOLDER,
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
                            const Divider(),
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
                        child: Text(
                          data.content ?? '-',
                          textAlign: TextAlign.justify,
                          style: AppTextStyle.bodyThin,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
