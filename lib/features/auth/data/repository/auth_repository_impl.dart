import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:dance_fever/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:dance_fever/features/auth/domain/entities/user_entity.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      return Right(user);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final user = await authLocalDataSource.getCachedUser();
      return Right(user != null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    // TODO: implement signInWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await authRemoteDataSource.signInWithGoogle();
      await authLocalDataSource.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authRemoteDataSource.signOut();
      final didClear = await authLocalDataSource.clearCachedUser();

      if (didClear) {
        return const Right(null);
      } else {
        return Left(CacheFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
