import 'package:intl/date_symbol_data_local.dart';

import '../injection_container.dart' as service_locator;

class InitializeApp {
  InitializeApp._();

  static Future<void> init() async {
    // Initialize service locator
    await service_locator.initLocator();

    // initialize date formating
    initializeDateFormatting();
  }
}
