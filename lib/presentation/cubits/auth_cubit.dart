import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../states/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthCubit(this.loginUsecase, this.registerUsecase) : super(AuthInitial());

  Future<bool> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await loginUsecase(email, password);
      emit(AuthSuccess(user));
      return true;
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await registerUsecase(email, password);
      emit(AuthSuccess(user));
      return true;
    } catch (e) {
      emit(AuthFailure(e.toString()));
      return false;
    }
  }
}
