import 'package:dance_fever/core/error/result.dart';
import 'package:dance_fever/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<Result> loginWithGoogle() {
    return remoteDataSource.loginWithGoogle();
  }

  @override
  Future<Result> logout() {
    return remoteDataSource.logout();
  }
}

final authRepositoryImpl = Provider(
  (ref) => AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider)),
);
