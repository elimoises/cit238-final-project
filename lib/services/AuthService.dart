// Class will handle functionalities related to Firebase
// Authentication

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_book_store/services/DatabaseService.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginUser(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(result);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerUser(String firstName, String lastName, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await DatabaseService(uid: result.user.uid).addUserData(email, firstName, lastName);

      print(result);
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future logoutUser() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      return null;
    }
  }

  Future checkIsLoggedIn() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return user;
    } catch (e) {
      return null;
    }
  }
}