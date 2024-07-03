import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'presentation/widgets/global/my_navbar.dart';

import 'core/utils/colors.dart';
import 'core/utils/route.dart';
import 'services/initialize_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force orientation portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await InitializeApp.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recovie',
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        primaryColor: AppColor.primary,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColor.primary,
              secondary: AppColor.secondary,
            ),
      ),
      home: const MyNavigationBar(),
      getPages: AppRoute.pageRoute,
    );
  }
}
