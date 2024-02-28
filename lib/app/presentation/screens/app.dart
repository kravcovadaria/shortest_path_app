import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webspark_test/utils/navigation/helpers/navigator_history.dart';
import 'package:webspark_test/utils/navigation/routes/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _router = AppRouter(navigatorKey: App.navigatorKey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.r, color: Colors.indigo),
            borderRadius: BorderRadius.circular(11.r),
          ),
        ),
      ),
      onGenerateTitle: (_) => "Тестове завдання",
      routeInformationParser: _router.defaultRouteParser(),
      routerDelegate: _router.delegate(
        navigatorObservers: () => [
          AutoRouteObserver(),
          NavigatorHistory(),
        ],
      ),
      builder: (context, child) => child ?? const SizedBox(),
    );
  }
}
