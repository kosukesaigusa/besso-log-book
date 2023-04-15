import 'package:auto_route/auto_route.dart';

import '../visitor_log/ui/visitor_logs.dart';
import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    RedirectRoute(path: '/', redirectTo: VisitorLogsPage.path),
    AutoRoute(
      path: VisitorLogsPage.path,
      page: VisitorLogsRoute.page,
    ),
  ];
}
