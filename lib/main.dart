import 'package:comme/blocs/app/app_bloc.dart';
import 'package:comme/routes/app_router.dart';
import 'package:comme/services/provider_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderService.initProviders(
      child: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          // Handle auth state changes if needed
        },
        child: Builder(
          builder: (context) {
            final appBloc = context.read<AppBloc>();
            return MaterialApp.router(
              title: 'Comme',
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter().router(appBloc),
            );
          },
        ),
      ),
    );
  }
}
