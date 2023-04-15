// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:besso_log_book/visitor_log/ui/visitor_logs.dart' as _i1;
import 'package:flutter/material.dart' as _i3;

abstract class $AppRouter extends _i2.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    VisitorLogsRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<VisitorLogsRouteArgs>(
          orElse: () => VisitorLogsRouteArgs(
              visitorLogId: queryParams.optString('visitorLogId')));
      return _i2.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.VisitorLogsPage(
          visitorLogId: args.visitorLogId,
          key: args.key,
        ),
      );
    }
  };
}

/// generated route for
/// [_i1.VisitorLogsPage]
class VisitorLogsRoute extends _i2.PageRouteInfo<VisitorLogsRouteArgs> {
  VisitorLogsRoute({
    String? visitorLogId,
    _i3.Key? key,
    List<_i2.PageRouteInfo>? children,
  }) : super(
          VisitorLogsRoute.name,
          args: VisitorLogsRouteArgs(
            visitorLogId: visitorLogId,
            key: key,
          ),
          rawQueryParams: {'visitorLogId': visitorLogId},
          initialChildren: children,
        );

  static const String name = 'VisitorLogsRoute';

  static const _i2.PageInfo<VisitorLogsRouteArgs> page =
      _i2.PageInfo<VisitorLogsRouteArgs>(name);
}

class VisitorLogsRouteArgs {
  const VisitorLogsRouteArgs({
    this.visitorLogId,
    this.key,
  });

  final String? visitorLogId;

  final _i3.Key? key;

  @override
  String toString() {
    return 'VisitorLogsRouteArgs{visitorLogId: $visitorLogId, key: $key}';
  }
}
