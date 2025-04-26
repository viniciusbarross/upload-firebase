import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth auth;

  AuthDatasource(this.auth);

  Future<UserCredential> login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> register(String email, String password) {
    return auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}