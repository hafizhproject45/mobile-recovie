import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recovie/core/utils/colors.dart';
import 'package:recovie/domain/entities/movies/detail_movie/teaser_entity.dart';
import 'package:recovie/presentation/cubit/detail_movie/get_teaser/get_teaser_cubit.dart';
import 'package:recovie/presentation/widgets/global/shimmer/my_shimmer_custom.dart';
import 'package:recovie/presentation/widgets/global/youtube_iframe.dart';

class TrailerSection extends StatefulWidget {
  final String title;

  const TrailerSection({
    required this.title,
    super.key,
  });

  @override
  State<TrailerSection> createState() => _TrailerSectionState();
}

class _TrailerSectionState extends State<TrailerSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        BlocBuilder<GetTeaserCubit, GetTeaserState>(
          builder: (context, state) {
            if (state is GetTeaserLoaded) {
              final List<TeaserEntity?> data = state.data;

              if (data.isEmpty || data[0]!.key!.isEmpty) {
                return Container(
                  height: 230,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: AppColor.shimmerHighlight,
                  ),
                  child: const Center(
                    child: Text('Teaser not available'),
                  ),
                );
              }

              return YoutubeIframe(
                ytKey: data[0]!.key!,
                title: '${widget.title} : ${data[0]!.name!}',
              );
            } else if (state is GetTeaserNotLoaded) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return ShimmerCustomWidget(
                height: 230,
                width: screenWidth,
              );
            }
          },
        )
      ],
    );
  }
}
