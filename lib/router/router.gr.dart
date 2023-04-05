// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:besso_log_book/visitor_log/ui/visitor_log_create.dart' as _i3;
import 'package:besso_log_book/visitor_log/ui/visitor_log_detail.dart' as _i1;
import 'package:besso_log_book/visitor_log/ui/visitor_logs.dart' as _i2;
import 'package:flutter/material.dart' as _i5;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    VisitorLogDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VisitorLogDetailRouteArgs>(
          orElse: () => VisitorLogDetailRouteArgs(
              visitorLogId: pathParams.getString('visitorLogId')));
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.VisitorLogDetailPage(
          visitorLogId: args.visitorLogId,
          key: args.key,
        ),
      );
    },
    VisitorLogsRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.VisitorLogsPage(),
      );
    },
    VisitorLogCreateRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.VisitorLogCreatePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.VisitorLogDetailPage]
class VisitorLogDetailRoute
    extends _i4.PageRouteInfo<VisitorLogDetailRouteArgs> {
  VisitorLogDetailRoute({
    required String visitorLogId,
    _i5.Key? key,
    List<_i4.PageRouteInfo>? children,
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

  static const _i4.PageInfo<VisitorLogDetailRouteArgs> page =
      _i4.PageInfo<VisitorLogDetailRouteArgs>(name);
}

class VisitorLogDetailRouteArgs {
  const VisitorLogDetailRouteArgs({
    required this.visitorLogId,
    this.key,
  });

  final String visitorLogId;

  final _i5.Key? key;

  @override
  String toString() {
    return 'VisitorLogDetailRouteArgs{visitorLogId: $visitorLogId, key: $key}';
  }
}

/// generated route for
/// [_i2.VisitorLogsPage]
class VisitorLogsRoute extends _i4.PageRouteInfo<void> {
  const VisitorLogsRoute({List<_i4.PageRouteInfo>? children})
      : super(
          VisitorLogsRoute.name,
          initialChildren: children,
        );

  static const String name = 'VisitorLogsRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.VisitorLogCreatePage]
class VisitorLogCreateRoute extends _i4.PageRouteInfo<void> {
  const VisitorLogCreateRoute({List<_i4.PageRouteInfo>? children})
      : super(
          VisitorLogCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'VisitorLogCreateRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
