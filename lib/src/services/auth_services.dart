import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up with email & password
  Future signUp(String email, String password) async {
    try {
      // Create user credential
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = result.user!; // TODO add to user doc using this instance uid
      // TODO add normal user role at firestore

      print("=====================================================");
      print(user);
      print("=====================================================");

      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
