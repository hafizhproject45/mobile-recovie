import 'package:flutter/material.dart';
import '../../../core/utils/utility.dart';

import '../../../core/utils/constants.dart';
import '../global/shimmer/my_shimmer_custom.dart';

class CardImage extends StatelessWidget {
  final String image;

  const CardImage({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(5), topLeft: Radius.circular(5)),
        child: Image.network(
          image.isNotEmpty
              ? '$IMAGE_URL$image'
              : Utility.imagePlaceHolder(175, 250),
          height: 250,
          width: 175,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const ShimmerCustomWidget(
              height: 250,
              width: 175,
            );
          },
        ),
      ),
    );
  }
}
