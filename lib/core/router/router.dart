import 'dart:async';

import 'package:dance_fever/features/Home/presentation/pages/home_page.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_state.dart';
import 'package:dance_fever/features/auth/presentation/pages/login_page.dart';
import 'package:dance_fever/features/auth/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  GoRouter get router => GoRouter(
    initialLocation: '/splash',
    // debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToSplash = state.matchedLocation == '/splash';

      if (authState is AuthUnauthenticatedState || authState is AuthErrorState) {
        return isGoingToLogin ? null : '/login';
      }

      if (authState is AuthAuthenticatedState) {
        if (isGoingToLogin || isGoingToSplash) {
          return '/home';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    print("GoRouterRefreshStream: ${stream.first}");
    notifyListeners();
    stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  // late final StreamSubscription _subscription;
}
