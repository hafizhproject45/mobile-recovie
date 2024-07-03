import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../cubit/search_movie/search_movie_cubit.dart';
import '../../widgets/global/textfield/my_text_textfield.dart';

import '../../../injection_container.dart';
import '../../cubit/movie_list/get_trending/get_trending_cubit.dart';
import '../../widgets/global/my_appbar.dart';
import '../../widgets/global/my_drawer.dart';
import '../../widgets/search/search_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final trendingCubit = sl<GetTrendingCubit>();
  final searchCubit = sl<SearchMovieCubit>();

  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => searchCubit,
        ),
        BlocProvider(
          create: (context) => trendingCubit..getData(),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => _onRefresh(context),
        child: Column(
          children: [
            const SizedBox(height: 30),
            MyTextFieldText(
              controller: _searchController,
              focusNode: _searchFocusNode,
              iconz: Icons.search,
              width: screenWidth * 0.85,
              name: 'Search',
              onFieldSubmitted: (value) => _onSearchSubmitted(value),
            ),
            const SizedBox(height: 20),
            SearchField(
              searchController: _searchController,
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchSubmitted(String query) {
    searchCubit.searchMovie(query.trim());
  }

  void _onRefresh(BuildContext context) {
    _searchController.clear();
    searchCubit.searchMovie('');
    trendingCubit.getData();
    _refreshController.refreshCompleted();
  }
}
