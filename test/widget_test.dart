// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:recovie/core/utils/constants.dart';

void main() {
  test('encryption password test', () {
    const String result = '$IMAGE_URL/74hLDKjD5aGYOotO6esUVaeISa2.jpg';

    print(result);

    expect(result, isNotEmpty);
  });
}
