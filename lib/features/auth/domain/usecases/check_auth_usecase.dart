import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CheckAuthUseCase {
  final AuthRepository repository;

  CheckAuthUseCase({required this.repository});

  Future<Either<Failure, bool>> call() async {
    return await repository.isAuthenticated();
  }
}
