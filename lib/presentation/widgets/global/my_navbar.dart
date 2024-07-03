// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import '../../../presentation/pages/search/main_search_page.dart';

import '../../pages/nowplaying/main_nowplaying.dart';
import '../../pages/upcoming/main_upcoming_page.dart';
import '../../../core/utils/colors.dart';
import '../../pages/home/main_home_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  final RxInt _selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.grey.shade900,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.grey.shade900,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
      onItemSelected: (index) {
        _selectedIndex.value = index;
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      _buildIndexedStackPage(const HomePage(), 'HomePage'),
      _buildIndexedStackPage(const SearchPage(), 'SearchPage'),
      _buildIndexedStackPage(const NowPlayingPage(), 'NowPlayingPage'),
      _buildIndexedStackPage(const UpcomingPage(), 'UpcomingPage'),
    ];
  }

  Widget _buildIndexedStackPage(Widget page, String key) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Container(
        key: PageStorageKey(key),
        child: page,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColor.primary,
        inactiveColorPrimary: AppColor.textSmall,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: AppColor.primary,
        inactiveColorPrimary: AppColor.textSmall,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.slow_motion_video),
        title: ("Now Playing"),
        activeColorPrimary: AppColor.primary,
        inactiveColorPrimary: AppColor.textSmall,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.local_movies_outlined),
        title: ("Upcoming"),
        activeColorPrimary: AppColor.primary,
        inactiveColorPrimary: AppColor.textSmall,
      ),
    ];
  }
}
