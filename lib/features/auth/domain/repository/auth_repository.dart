import 'package:dance_fever/core/error/result.dart';

abstract class AuthRepository {
  Future<Result<void>> loginWithGoogle();
  Future<Result<void>> loginWithApple();
  Future<Result<void>> logout();
}
