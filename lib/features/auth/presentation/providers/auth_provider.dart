import 'dart:async';

import 'package:dance_fever/core/error/result.dart';
import 'package:dance_fever/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dance_fever/features/auth/domain/usecases/login_with_google.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    print("this is AuthNotifier build for FutureOr<void>");
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryImpl);

    final result = LoginWithGoogle(repository).call();

    state = switch (await result) {
      Success<void>() => state = const AsyncValue.data(null),
      Failure<void>() => state = const AsyncValue.error(
        Failure<void>(UnauthorizedError()),
        StackTrace.empty,
      ),
    };
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryImpl);

    final result = repository.logout();

    state = switch (await result) {
      Success<void>() => state = const AsyncValue.data(null),
      Failure<void>() => state = const AsyncValue.error(
        Failure<void>(UnauthorizedError()),
        StackTrace.empty,
      ),
    };
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthNotifier, void>(
  () => AuthNotifier(),
);
