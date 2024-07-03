import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          backgroundColor: Colors.grey.shade900,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.maxFinite,
                height: 80,
                color: Colors.grey.shade400,
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/icon/ic_recovie.png',
                  width: 100,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => Get.toNamed('/about'),
                child: const ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                  title: Text(
                    'About this application',
                    style: AppTextStyle.bodyWhite,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
