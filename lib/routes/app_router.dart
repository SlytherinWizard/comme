import 'package:comme/pages/auth/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:comme/pages/earth/earth_page.dart';
import 'package:comme/routes/routes.dart';
import 'package:comme/pages/chat/chat_page.dart';
import 'package:comme/pages/chats/chats_page.dart';
import 'package:comme/pages/order/order_page.dart';
import 'package:comme/pages/orders/orders_page.dart';
import 'package:comme/pages/profile/profile_page.dart';
import 'package:comme/pages/warehouse/warehouse_page.dart';

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
        GoRoute(
          path: Routes.chat,
          builder: (context, state) => const ChatPage(),
        ),
        GoRoute(
          path: Routes.chats,
          builder: (context, state) => const ChatsPage(),
        ),
        GoRoute(
          path: Routes.order,
          builder: (context, state) => const OrderPage(),
        ),
        GoRoute(
          path: Routes.orders,
          builder: (context, state) => const OrdersPage(),
        ),
        GoRoute(
          path: Routes.profile,
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: Routes.warehouse,
          builder: (context, state) => const WarehousePage(),
        ),
      ],
    );
  }
}
