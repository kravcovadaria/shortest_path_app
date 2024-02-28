import 'package:webspark_test/utils/utils.dart';
import 'package:flutter/material.dart';

class NavigatorHistory extends NavigatorObserver {
  static String? lastRoute;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    lastRoute = route.settings.name;
    Utils.debugPrint(lastRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    lastRoute = previousRoute?.settings.name;
    Utils.debugPrint(lastRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didRemove(Route<dynamic>? route, Route<dynamic>? previousRoute) {}
}
