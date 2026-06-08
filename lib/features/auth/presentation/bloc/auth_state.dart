import 'package:dance_fever/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthAuthenticatedState extends AuthState {
  final UserEntity userEntity;
  AuthAuthenticatedState({required this.userEntity});

  @override
  List<Object?> get props => [userEntity];
}

class AuthUnauthenticatedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
