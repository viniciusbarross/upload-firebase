import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final result = await datasource.login(email, password);
    return UserEntity(id: result.user!.uid, email: result.user!.email!);
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final result = await datasource.register(email, password);
    return UserEntity(id: result.user!.uid, email: result.user!.email!);
  }
}