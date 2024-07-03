import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../core/utils/text_style.dart';

class MySearchTextField extends StatefulWidget {
  final double width;

  const MySearchTextField({
    required this.width,
    super.key,
  });

  @override
  State<MySearchTextField> createState() => _MySearchTextFieldState();
}

class _MySearchTextFieldState extends State<MySearchTextField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintStyle: AppTextStyle.mediumWhite,
          hintText: 'Search',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {
              if (_searchController.text.isEmpty) {
                Get.back();
              } else {
                Get.toNamed('/search');
              }
            },
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
          ),
        ),
      ),
    );
  }
}
