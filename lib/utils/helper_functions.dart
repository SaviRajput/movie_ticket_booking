import 'dart:math';

import 'package:intl/intl.dart';

class HelperFunctions {
  static String formatDateTime(DateTime dateTime) {
    // Define the date and time format
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    // Format the DateTime object into a string
    final String formattedDateTime = formatter.format(dateTime);
    // Return the formatted string
    return formattedDateTime;
  }

  static String generateRandomNumber() {
    const chars =
        '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
