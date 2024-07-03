import 'dart:math';

import 'package:intl/intl.dart';

class Utility {
  /// Format date to `25 April 2024`
  static String formatDateFromString(String dateString) {
    try {
      // Parse the date string
      DateTime date = DateTime.parse(dateString);

      // Format the date
      DateFormat formatter = DateFormat('dd MMM yyyy');
      return formatter.format(date);
    } catch (e) {
      // Handle invalid date format
      return '-';
    }
  }

  /// Format date to `25 April 2024`
  static String formatOnlyDate(DateTime? date) {
    if (date == null) {
      return '-';
    }

    DateFormat formattor = DateFormat('dd MMMM yyyy');
    return formattor.format(date);
  }

  static String formatDateMain(DateTime? date) {
    if (date == null) {
      return '-';
    }

    DateFormat formattor = DateFormat('EEEE, dd MMMM yyyy');
    return formattor.format(date);
  }

  /// Format date to `09:00:00`
  static String formatDateToSecond(DateTime? date) {
    if (date == null) {
      return '-';
    }
    DateFormat formattor = DateFormat('HH:mm:ss');
    return formattor.format(date);
  }

  /// Format date to `09:00`
  static String formatDateToHour(DateTime? date) {
    if (date == null) {
      return '-';
    }
    DateFormat formattor = DateFormat('HH:mm');
    return formattor.format(date);
  }

  /// Format number to `1.000`
  static String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number).replaceAll(',', '.');
  }

  /// Format int to `09:00`
  static String formatIntToMinutesAndSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Format int to `4 days ago`
  static String timeAgoFormat(String rawDate) {
    DateTime date = DateTime.parse(rawDate);
    Duration difference = DateTime.now().difference(date);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds} seconds ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inDays} days ago";
    }
  }

  /// Format int to `0.0`
  static double formatAverage(double? number) {
    if (number == null) {
      return 0.0;
    }

    NumberFormat formatter = NumberFormat('0.0');
    String formattedString = formatter.format(number);
    return double.parse(formattedString);
  }

  /// Generate random string
  static getRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random.secure();
    List<String> result = List.generate(length, (index) {
      final randomIndex = random.nextInt(charset.length);
      return charset[randomIndex];
    });
    return result.join();
  }
}
