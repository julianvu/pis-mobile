import 'package:firebase_auth/firebase_auth.dart';
import 'package:pis_mobile/models/user.dart';

abstract class AuthRepo {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<bool> isAuthenticated();
}

class FirebaseAuthRepo extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<User> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return User(name: user.displayName, email: user.email);
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    AuthResult authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (authResult.user == null) {
      throw AuthException("1", "Invalid credentials");
    }
    return User(name: authResult.user.displayName, email: email);
  }

  @override
  Future<void> signOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }

  @override
  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser() != null;
  }
}
