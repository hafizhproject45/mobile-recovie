import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/movies/detail_movie/credits_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/detail_movie/get_credits/get_credits_cubit.dart';
import '../../widgets/global/my_appbar.dart';

class MoreCredits extends StatefulWidget {
  const MoreCredits({super.key});

  @override
  State<MoreCredits> createState() => _MoreCreditsState();
}

class _MoreCreditsState extends State<MoreCredits> {
  final int id = Get.arguments['id'];
  final String title = Get.arguments['title'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetCreditsCubit>()..getData(id),
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        isMenu: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'More Credits',
              style: AppTextStyle.headingWhite,
            ),
            Text(
              title,
              style: AppTextStyle.bodyWhite,
            ),
            const SizedBox(height: 30),
            BlocBuilder<GetCreditsCubit, GetCreditsState>(
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

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: credits.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // number of items in each row
                      mainAxisSpacing: 15, // spacing between rows
                      crossAxisSpacing: 15, // spacing between columns
                      childAspectRatio: 1 / 3,
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
                                          const BorderRadiusDirectional
                                              .vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        data?.profilePath != null
                                            ? '$IMAGE_URL${data!.profilePath}'
                                            : Utility.imagePlaceHolder(
                                                250, 400),
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
                              borderRadius:
                                  const BorderRadiusDirectional.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                data?.profilePath != null
                                    ? '$IMAGE_URL${data!.profilePath}'
                                    : 'https://via.placeholder.com/150x180.png?text=No+Image',
                                width: 150,
                                height: 180,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
            ),
          ],
        ),
      ),
    );
  }
}
