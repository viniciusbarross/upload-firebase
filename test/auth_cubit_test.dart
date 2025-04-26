import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:upload_app/domain/entities/user_entity.dart';
import 'package:upload_app/domain/usecases/login_usecase.dart';
import 'package:upload_app/domain/usecases/register_usecase.dart';
import 'package:upload_app/presentation/cubits/auth_cubit.dart';
import 'package:upload_app/presentation/states/auth_state.dart';

class MockLogin extends Mock implements LoginUsecase {
  @override
  Future<UserEntity> call(String email, String password) async {
    return UserEntity(email: email, id: '123'); // Retorna um UserEntity válido
  }
}

class MockRegister extends Mock implements RegisterUsecase {
  @override
  Future<UserEntity> call(String email, String password) async {
    return UserEntity(email: email, id: '123');
  }
}

void main() {
  late MockLogin login;
  late MockRegister register;
  late AuthCubit cubit;

  setUp(() {
    login = MockLogin();
    register = MockRegister();
    cubit = AuthCubit(login, register);
  });

  test('login emits AuthSuccess', () async {
    await cubit.login('user', 'pass');
    expect(cubit.state, isA<AuthSuccess>());
  });

  test('register emits AuthSuccess', () async {
    await cubit.register('user', 'pass');
    expect(cubit.state, isA<AuthSuccess>());
  });
}
