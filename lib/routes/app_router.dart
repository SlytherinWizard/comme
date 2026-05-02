import 'package:go_router/go_router.dart';
import 'package:comme/pages/earth/earth_page.dart';
import 'package:comme/routes/routes.dart';

class AppRouter {
  GoRouter router() {
    return GoRouter(
      routes: [
        GoRoute(
          path: Routes.earth,
          builder: (context, state) => const EarthPage(),
        ),
      ],
    );
  }
}
