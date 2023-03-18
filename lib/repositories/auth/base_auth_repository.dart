import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthRepository {
  Stream<User?> get user;
  Future<User?> signUp({
    required String email,
    required String password,
  });
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
