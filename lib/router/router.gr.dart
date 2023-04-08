// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:besso_log_book/router/root_page.dart' as _i4;
import 'package:besso_log_book/visitor_log/ui/visitor_log_create.dart' as _i2;
import 'package:besso_log_book/visitor_log/ui/visitor_log_detail.dart' as _i1;
import 'package:besso_log_book/visitor_log/ui/visitor_logs.dart' as _i3;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    VisitorLogDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VisitorLogDetailRouteArgs>(
          orElse: () => VisitorLogDetailRouteArgs(
              visitorLogId: pathParams.getString('visitorLogId')));
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.VisitorLogDetailPage(
          visitorLogId: args.visitorLogId,
          key: args.key,
        ),
      );
    },
    VisitorLogCreateRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.VisitorLogCreatePage(),
      );
    },
    VisitorLogsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.VisitorLogsPage(),
      );
    },
    RootRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RootPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.VisitorLogDetailPage]
class VisitorLogDetailRoute
    extends _i5.PageRouteInfo<VisitorLogDetailRouteArgs> {
  VisitorLogDetailRoute({
    required String visitorLogId,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          VisitorLogDetailRoute.name,
          args: VisitorLogDetailRouteArgs(
            visitorLogId: visitorLogId,
            key: key,
          ),
          rawPathParams: {'visitorLogId': visitorLogId},
          initialChildren: children,
        );

  static const String name = 'VisitorLogDetailRoute';

  static const _i5.PageInfo<VisitorLogDetailRouteArgs> page =
      _i5.PageInfo<VisitorLogDetailRouteArgs>(name);
}

class VisitorLogDetailRouteArgs {
  const VisitorLogDetailRouteArgs({
    required this.visitorLogId,
    this.key,
  });

  final String visitorLogId;

  final _i6.Key? key;

  @override
  String toString() {
    return 'VisitorLogDetailRouteArgs{visitorLogId: $visitorLogId, key: $key}';
  }
}

/// generated route for
/// [_i2.VisitorLogCreatePage]
class VisitorLogCreateRoute extends _i5.PageRouteInfo<void> {
  const VisitorLogCreateRoute({List<_i5.PageRouteInfo>? children})
      : super(
          VisitorLogCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'VisitorLogCreateRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.VisitorLogsPage]
class VisitorLogsRoute extends _i5.PageRouteInfo<void> {
  const VisitorLogsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          VisitorLogsRoute.name,
          initialChildren: children,
        );

  static const String name = 'VisitorLogsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RootPage]
class RootRoute extends _i5.PageRouteInfo<void> {
  const RootRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
