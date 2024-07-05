import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/colors.dart';
import '../../../domain/entities/movies/detail_movie/teaser_entity.dart';
import '../../cubit/detail_movie/get_teaser/get_teaser_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import '../global/youtube_iframe.dart';

class TeaserSection extends StatefulWidget {
  final String title;

  const TeaserSection({
    required this.title,
    super.key,
  });

  @override
  State<TeaserSection> createState() => _TeaserSectionState();
}

class _TeaserSectionState extends State<TeaserSection> {
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
