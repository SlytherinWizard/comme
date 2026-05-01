import 'package:comme_flutter/repositories/earth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../repositories/auth_repository.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/earth/earth_bloc.dart';

class ProviderService {
  static Widget initProviders({required Widget child}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<EarthRepository>(
          create: (context) => EarthRepository(),
        ),
      ],
      child: MultiBlocProvider(providers: _initBlocProviders(), child: child),
    );
  }

  static List<BlocProvider> _initBlocProviders() {
    return [
      BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(authRepository: context.read<AuthRepository>()),
      ),
      BlocProvider<EarthBloc>(
        create: (context) =>
            EarthBloc(earthRepository: context.read<EarthRepository>()),
      ),
    ];
  }
}
