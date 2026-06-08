import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
}
