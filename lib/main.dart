import 'package:comme/routes/app_router.dart';
import 'package:comme/services/provider_service.dart';
import 'package:flutter/material.dart';

// TODO:
// 1 - Firebase configuration Android and IOS
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return ProviderService.initProviders(
      child: MaterialApp.router(
        title: 'Comme',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().router(),
      ),
    );
  }
}
