import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:dance_fever/features/auth/domain/usecases/logout_usecase.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_event.dart';
import 'package:dance_fever/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithGoogleUseCase loginUseCase;
  final CheckAuthUseCase checkAuthUserCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.checkAuthUserCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitialState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginWithGoogleRequested>(_onAuthLoginWithGoogleRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future _onAuthCheckRequested(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final result = await checkAuthUserCase();
    await result.fold(
      (l) {
        emit(AuthUnauthenticatedState());
      },
      (r) async {
        if (r) {
          final userResult = await getCurrentUserUseCase();
          await userResult.fold(
            (l) {
              emit(AuthUnauthenticatedState());
            },
            (r) {
              if (r != null) {
                emit(AuthAuthenticatedState(userEntity: r));
              } else {
                emit(AuthUnauthenticatedState());
              }
            },
          );
        } else {
          emit(AuthUnauthenticatedState());
        }
      },
    );
  }

  Future _onAuthLoginWithGoogleRequested(
    AuthLoginWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await loginUseCase();
    result.fold(
      (l) {
        String message = "Auth error";

        if (l is ServerFailure) {
          message = "Server error";
        } else if (l is NetworkFailure) {
          message = "Network error";
        } else if (l is AuthFailure) {
          message = "Auth error";
        }

        emit(AuthErrorState(message: message));
      },
      (r) {
        emit(AuthAuthenticatedState(userEntity: r));
      },
    );
  }

  Future _onAuthLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final result = await logoutUseCase();
    result.fold(
      (l) {
        emit(AuthErrorState(message: "Logout error"));
      },
      (r) {
        emit(AuthUnauthenticatedState());
      },
    );
  }
}
