import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/app_admin.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final FirebaseAuth _auth;

  /// get current user
  AppAdmin? getCurrentUser() {
    final admin = _auth.currentUser;
    return admin == null ? null : AppAdmin(uid: admin.uid, isAnonymous: admin.isAnonymous);
  }

  /// Notifies about changes to the user's sign-in state
  /// (such as sign-in or sign-out).
  Stream<AppAdmin?> authStateChanges() {
    return _auth.authStateChanges().map((admin) {
      // converts to AppUser class or null
      return admin == null ? null : AppAdmin(uid: admin.uid, isAnonymous: admin.isAnonymous);
    });
  }

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Future<void> signInWithEmailAndPassword({required String email, required String password}) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<String> getIdToken() async {
    final user = _auth.currentUser;
    final String? token = await user?.getIdToken(true);
    return token ?? '';
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(FirebaseAuth.instance);
}
