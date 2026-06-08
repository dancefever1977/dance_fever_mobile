import 'package:dance_fever/core/error/failures.dart';
import 'package:dance_fever/features/auth/domain/entities/user_entity.dart';
import 'package:dance_fever/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}
