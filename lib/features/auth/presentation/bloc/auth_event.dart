import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginWithGoogleRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthLoginWithAppleRequested extends AuthEvent {}
