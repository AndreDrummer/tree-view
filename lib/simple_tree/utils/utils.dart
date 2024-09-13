import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Utils {
  static DateTime startExecutionTime({String? methodName = ""}) {
    final DateTime now = DateTime.now();
    debugPrint(
        "Start execution $methodName ${DateFormat('dd/MM/yyyy HH:mm:ss:SSS').format(now)}");
    return now;
  }

  static void endExecutionTime(
    DateTime startExecutionTime, {
    String? methodName = "",
  }) {
    final DateTime now = DateTime.now();

    debugPrint(
        "Finish execution $methodName ${DateFormat('dd/MM/yyyy HH:mm:ss:SSS').format(now)}");
    debugPrint(
        "Duration: ${now.difference(startExecutionTime).inMilliseconds}ms");
  }
}
