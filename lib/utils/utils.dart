import 'dart:math';

import 'package:flutter/foundation.dart';

class Utils {
  static bool get isDebug => kDebugMode;

  static void debugPrint(String? value, [dynamic message]) {
    if (kDebugMode) print(message == null ? value : '$value: $message');
  }

  static void errorPrint(dynamic e, StackTrace? stack) {
    debugPrint('$e${stack == null ? '' : '\n$stack'}');
  }

  static double tryDouble(dynamic it) {
    if (it is num) return it.toDouble();
    if (it is String) return double.tryParse(it) ?? 0.0;
    return 0.0;
  }

  static num abs(num value) => max(value, -value);
}
