import 'package:comme_flutter/pages/auth/auth_page.dart';
import 'package:comme_flutter/pages/earth/earth_page.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';

class AppRouter {
  List<GoRoute> _defineRoutes() => [
    GoRoute(path: AppRoutes.auth, builder: (context, state) => AuthPage()),
    GoRoute(path: AppRoutes.earth, builder: (context, state) => EarthPage()),
  ];

  GoRouter router() => GoRouter(
    initialLocation: AppRoutes.auth,
    debugLogDiagnostics: true,
    routes: _defineRoutes(),
  );
}
