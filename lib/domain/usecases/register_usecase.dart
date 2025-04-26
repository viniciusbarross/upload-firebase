import '../repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.register(email, password);
  }
}