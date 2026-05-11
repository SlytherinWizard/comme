import 'package:comme/pages/auth/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:comme/pages/earth/earth_page.dart';
import 'package:comme/routes/routes.dart';

class AppRouter {
  GoRouter router() {
    return GoRouter(
      initialLocation: Routes.auth,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.auth,
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          path: Routes.earth,
          builder: (context, state) => const EarthPage(),
        ),
      ],
    );
  }
}
