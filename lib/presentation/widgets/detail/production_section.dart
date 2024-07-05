import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/movies/detail_movie/production_entity.dart';
import '../../cubit/detail_movie/get_production/get_production_cubit.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';

class ProductionSection extends StatefulWidget {
  const ProductionSection({super.key});

  @override
  State<ProductionSection> createState() => _ProductionSectionState();
}

class _ProductionSectionState extends State<ProductionSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const Text(
          'Production by',
          style: AppTextStyle.bodyWhite,
        ),
        const SizedBox(height: 10),
        BlocBuilder<GetProductionCubit, GetProductionState>(
          builder: (context, state) {
            if (state is GetProductionLoaded) {
              final List<ProductionEntity?> production = state.data;

              if (production.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Center(
                    child: Text(
                      'Production not available',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: screenWidth,
                height: screenHeight * 0.15, // 15% of the screen height
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: production.length,
                    itemBuilder: (context, index) {
                      final data = production[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              data?.logoPath != null
                                  ? Image.network(
                                      '$IMAGE_URL${data!.logoPath}',
                                      width: screenWidth * 0.12,
                                      color: Colors.white,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        Utility.imagePlaceHolder(200, 100),
                                        width: screenWidth * 0.2,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              Text(
                                data?.name ?? '-',
                                style: AppTextStyle
                                    .bodyWhite, // Apply white text style
                                overflow: TextOverflow
                                    .ellipsis, // Handle text overflow
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            } else if (state is GetProductionNotLoaded) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
