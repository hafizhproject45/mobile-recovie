import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_trans;
import 'package:recovie/presentation/pages/detail/more_credits.dart';
import '../../presentation/pages/detail/main_detail_page.dart';
import '../../presentation/pages/search/main_search_page.dart';
import '../../presentation/pages/upcoming/main_upcoming_page.dart';
import '../../presentation/widgets/global/my_navbar.dart';

import '../../presentation/pages/about/main_about_page.dart';

class AppRoute {
  static List<GetPage> get pageRoute => [
        GetPage<MyNavigationBar>(
          name: '/navbar',
          page: () => const MyNavigationBar(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
        GetPage<UpcomingPage>(
          name: '/upcoming',
          page: () => const UpcomingPage(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
        GetPage<DetailPage>(
          name: '/detail/:id',
          page: () => const DetailPage(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
        GetPage<MoreCredits>(
          name: '/more-credits',
          page: () => const MoreCredits(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
        GetPage<SearchPage>(
          name: '/search',
          page: () => const SearchPage(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
        GetPage<AboutPage>(
          name: '/about',
          page: () => const AboutPage(),
          transition: get_trans.Transition.leftToRightWithFade,
        ),
      ];
}
