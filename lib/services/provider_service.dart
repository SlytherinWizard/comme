import 'package:comme/blocs/app/app_bloc.dart';
import 'package:comme/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderService {
  static Widget initProviders({required Widget child}) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (context) {
              final appBloc = AppBloc(
                authRepository: context.read<AuthRepository>(),
              );
              // Initialize auth state check
              appBloc.add(AppInitialized());
              return appBloc;
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
