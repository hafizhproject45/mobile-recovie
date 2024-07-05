import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/movie_list/movie_list_entity.dart';
import '../../../domain/entities/movies/detail_movie/credits_entity.dart';
import '../../cubit/detail_movie/get_credits/get_credits_cubit.dart';

import '../../../core/utils/constants.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class CreditsSection extends StatefulWidget {
  final MovieListEntity args;

  const CreditsSection({
    required this.args,
    super.key,
  });

  @override
  State<CreditsSection> createState() => _CreditsSectionState();
}

class _CreditsSectionState extends State<CreditsSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GetCreditsCubit, GetCreditsState>(
      builder: (context, state) {
        if (state is GetCreditsLoaded) {
          final List<CreditsEntity?> credits = state.data;

          if (credits.isEmpty) {
            return const Center(
              child: Text(
                'Credits not available',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Column(
            children: [
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 15, // spacing between rows
                  crossAxisSpacing: 15, // spacing between columns
                  childAspectRatio: 1 / 2.8,
                ),
                itemBuilder: (context, index) {
                  final data = credits[index];

                  return GestureDetector(
                    onTap: () {
                      Get.dialog(
                        Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      const BorderRadiusDirectional.vertical(
                                    top: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    data?.profilePath != null
                                        ? '$IMAGE_URL${data!.profilePath}'
                                        : Utility.imagePlaceHolder(250, 400),
                                    width: screenWidth * 0.8,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.8,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(10)),
                                    color: AppColor.darkCard,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 30,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data?.knownFor ?? '-',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          data?.name ?? '-',
                                          style: AppTextStyle.headingWhite,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          data?.castFor ?? '-',
                                          style: AppTextStyle.bodyWhite,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadiusDirectional.vertical(
                            top: Radius.circular(10),
                          ),
                          child: Image.network(
                            data?.profilePath != null
                                ? '$IMAGE_URL${data!.profilePath}'
                                : Utility.imagePlaceHolder(150, 180),
                            width: 150,
                            height: 180,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const ShimmerCustomWidget(
                                height: 180,
                                width: 150,
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(10)),
                            color: AppColor.darkCard,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data?.knownFor ?? '-',
                                  style: const TextStyle(
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        data?.name ?? '-',
                                        style: AppTextStyle.bodyWhite,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        data?.castFor ?? '-',
                                        style: AppTextStyle.mediumWhite,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => Get.toNamed('/more-credits', arguments: {
                    'id': widget.args.id,
                    'title': widget.args.title,
                  }),
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'More credits',
                      style: TextStyle(color: AppColor.primary),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is GetCreditsNotLoaded) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // number of items in each row
              mainAxisSpacing: 15, // spacing between rows
              crossAxisSpacing: 15, // spacing between columns
              childAspectRatio: 1 / 2,
            ),
            itemBuilder: (context, index) {
              return ShimmerCustomWidget(
                width: double.infinity,
                radius: BorderRadius.circular(10),
              );
            },
          );
        }
      },
    );
  }
}
