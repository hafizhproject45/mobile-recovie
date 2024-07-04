import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:recovie/core/utils/text_style.dart';
import 'package:recovie/domain/entities/movies/detail_movie/teaser_entity.dart';
import 'package:recovie/injection_container.dart';
import 'package:recovie/presentation/cubit/detail_movie/get_teaser/get_teaser_cubit.dart';
import 'package:recovie/presentation/widgets/global/my_appbar.dart';

class MoreTeaser extends StatefulWidget {
  const MoreTeaser({super.key});

  @override
  State<MoreTeaser> createState() => _MoreTeaserState();
}

class _MoreTeaserState extends State<MoreTeaser> {
  final int id = Get.arguments['id'];
  final String title = Get.arguments['title'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetTeaserCubit>()..getData(id),
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        isMenu: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'More Teaser',
            style: AppTextStyle.headingWhite,
          ),
          Text(
            title,
            style: AppTextStyle.bodyWhite,
          ),
          const SizedBox(height: 30),
          Expanded(
            child: BlocBuilder<GetTeaserCubit, GetTeaserState>(
              builder: (context, state) {
                if (state is GetTeaserLoaded) {
                  final List<TeaserEntity?> teaser = state.data;

                  return ListView.builder(
                    itemCount: teaser.length,
                    itemBuilder: (context, index) {
                      final data = teaser[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          color: Colors.grey,
                          height: 200,
                          width: screenWidth,
                          child: Text(data?.name ?? '-'),
                        ),
                      );
                    },
                  );
                } else if (state is GetTeaserNotLoaded) {
                  return const Center(
                    child: Text('something went wrong'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
