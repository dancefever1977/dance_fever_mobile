import 'package:equatable/equatable.dart';

// domain layer

sealed class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class AuthFailure extends Failure {}

class NetworkFailure extends Failure {}
