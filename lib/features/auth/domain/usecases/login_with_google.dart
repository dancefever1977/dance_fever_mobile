import 'package:dance_fever/core/error/result.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';

class LoginWithGoogle {
  final AuthRepository authRepository;

  LoginWithGoogle(this.authRepository);
  Future<Result<void>> call() async {
    return authRepository.loginWithGoogle();
  }
}
