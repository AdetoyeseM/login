import 'package:firebase_auth/firebase_auth.dart';
import 'package:net9ja/model/user.dart';

class AuthService {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _authService.onAuthStateChanged
//.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future signInAnony() async {
    try {
      AuthResult result = await _authService.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in anon

//sign n Email

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _authService.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Register Email

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _authService.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//Sign out
  Future signOut() async {
    try {
      return await _authService.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
