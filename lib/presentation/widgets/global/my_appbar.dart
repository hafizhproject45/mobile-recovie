// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  bool isMenu;

  MyAppBar({
    this.isMenu = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Image.asset(
          'assets/images/icon/ic_recovie.png',
          width: 100,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
        leading: isMenu
            ? IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              )
            : IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
