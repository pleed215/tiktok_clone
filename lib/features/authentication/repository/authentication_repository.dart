import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;

  User? get user => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(
      {email = String, password = String}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> loginWithGithub() async {
    final githubAuthProvider = GithubAuthProvider();
    await _firebaseAuth.signInWithProvider(githubAuthProvider);
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
final authStateStream = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
