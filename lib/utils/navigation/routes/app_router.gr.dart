// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    PreviewRoute.name: (routeData) {
      final args = routeData.argsAs<PreviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PreviewScreen(
          key: args.key,
          result: args.result,
        ),
      );
    },
    ProcessRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProcessScreen(),
      );
    },
    ResultListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ResultListScreen(),
      );
    },
  };
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PreviewScreen]
class PreviewRoute extends PageRouteInfo<PreviewRouteArgs> {
  PreviewRoute({
    Key? key,
    required ShortestPath result,
    List<PageRouteInfo>? children,
  }) : super(
          PreviewRoute.name,
          args: PreviewRouteArgs(
            key: key,
            result: result,
          ),
          initialChildren: children,
        );

  static const String name = 'PreviewRoute';

  static const PageInfo<PreviewRouteArgs> page =
      PageInfo<PreviewRouteArgs>(name);
}

class PreviewRouteArgs {
  const PreviewRouteArgs({
    this.key,
    required this.result,
  });

  final Key? key;

  final ShortestPath result;

  @override
  String toString() {
    return 'PreviewRouteArgs{key: $key, result: $result}';
  }
}

/// generated route for
/// [ProcessScreen]
class ProcessRoute extends PageRouteInfo<void> {
  const ProcessRoute({List<PageRouteInfo>? children})
      : super(
          ProcessRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProcessRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResultListScreen]
class ResultListRoute extends PageRouteInfo<void> {
  const ResultListRoute({List<PageRouteInfo>? children})
      : super(
          ResultListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResultListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
