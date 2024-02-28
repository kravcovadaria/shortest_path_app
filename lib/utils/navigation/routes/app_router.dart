import 'package:flutter/cupertino.dart';
import 'package:webspark_test/app/presentation/screens/main_screen.dart';
import 'package:webspark_test/shortest_path/data/models/shortest_path.dart';
import 'package:webspark_test/shortest_path/presentation/screens/process_screen.dart';
import 'package:webspark_test/shortest_path/presentation/screens/result_list_screen.dart';
import 'package:webspark_test/shortest_path/presentation/screens/preview_screen.dart';
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, path: '/'),
        AutoRoute(page: ProcessRoute.page),
        AutoRoute(page: ResultListRoute.page),
        AutoRoute(page: PreviewRoute.page),
      ];
}
