import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
