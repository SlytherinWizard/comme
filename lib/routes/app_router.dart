import 'dart:async';

import 'package:comme/blocs/app/app_bloc.dart';
import 'package:comme/pages/auth/auth_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:comme/pages/earth/earth_page.dart';
import 'package:comme/routes/routes.dart';
import 'package:comme/pages/chat/chat_page.dart';
import 'package:comme/pages/chats/chats_page.dart';
import 'package:comme/pages/order/order_page.dart';
import 'package:comme/pages/orders/orders_page.dart';
import 'package:comme/pages/profile/profile_page.dart';
import 'package:comme/pages/warehouse/warehouse_page.dart';

class AppRouter {
  GoRouter router(AppBloc appBloc) {
    final refreshListener = _AppBlocRefreshListenable(appBloc);

    return GoRouter(
      initialLocation: Routes.auth,
      debugLogDiagnostics: true,
      refreshListenable: refreshListener,
      redirect: (context, state) {
        final isAuthenticated =
            appBloc.state.authStatus == AuthStatus.authenticated;
        final isAuthPage = state.uri.path == Routes.auth;

        // If authenticated and on auth page, redirect to home
        if (isAuthenticated && isAuthPage) {
          return Routes.earth;
        }

        // If not authenticated and not on auth page, redirect to auth
        if (!isAuthenticated && !isAuthPage) {
          return Routes.auth;
        }

        return null;
      },
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

class _AppBlocRefreshListenable extends ChangeNotifier {
  late final StreamSubscription<AppState> _subscription;

  _AppBlocRefreshListenable(AppBloc appBloc) {
    _subscription = appBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
