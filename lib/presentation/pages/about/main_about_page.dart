import 'package:flutter/material.dart';
import '../../widgets/global/my_appbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isMenu: false,
      ),
    );
  }
}
