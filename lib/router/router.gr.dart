// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:besso_log_book/visitor_log/ui/visitor_log_detail.dart' as _i1;
import 'package:besso_log_book/visitor_log/ui/visitor_logs.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    VisitorLogDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VisitorLogDetailRouteArgs>(
          orElse: () => VisitorLogDetailRouteArgs(
              visitorLogId: pathParams.getString('visitorLogId')));
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.VisitorLogDetailPage(
          visitorLogId: args.visitorLogId,
          key: args.key,
        ),
      );
    },
    VisitorLogsRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.VisitorLogsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.VisitorLogDetailPage]
class VisitorLogDetailRoute
    extends _i3.PageRouteInfo<VisitorLogDetailRouteArgs> {
  VisitorLogDetailRoute({
    required String visitorLogId,
    _i4.Key? key,
    List<_i3.PageRouteInfo>? children,
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

  static const _i3.PageInfo<VisitorLogDetailRouteArgs> page =
      _i3.PageInfo<VisitorLogDetailRouteArgs>(name);
}

class VisitorLogDetailRouteArgs {
  const VisitorLogDetailRouteArgs({
    required this.visitorLogId,
    this.key,
  });

  final String visitorLogId;

  final _i4.Key? key;

  @override
  String toString() {
    return 'VisitorLogDetailRouteArgs{visitorLogId: $visitorLogId, key: $key}';
  }
}

/// generated route for
/// [_i2.VisitorLogsPage]
class VisitorLogsRoute extends _i3.PageRouteInfo<void> {
  const VisitorLogsRoute({List<_i3.PageRouteInfo>? children})
      : super(
          VisitorLogsRoute.name,
          initialChildren: children,
        );

  static const String name = 'VisitorLogsRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
