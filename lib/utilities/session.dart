
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Session {

  static final FirebaseAuth _authenticator = FirebaseAuth.instance;

  //Get User
  //-------------------------------------------------------------------------------------------
  static FirebaseUser getCurrentUser() {
      _getCurrentUser().then((FirebaseUser user) { return user; });
  }

  static Future<FirebaseUser> _getCurrentUser() async {
    return await _authenticator.currentUser();
  }

  //Login
  //-------------------------------------------------------------------------------------------

  static bool login(String email, String password) {
    _login(email, password).then((bool success) { return success; });
  }

  static Future<bool> _login(String email, String password) async {
    return await _authenticator.signInWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) { return true; })
        .catchError((Error e) { return false; });
  }

  //Create User
  //-------------------------------------------------------------------------------------------

  static bool createUser(String email, String password) {
    _createUser(email, password).then((bool success) { return success; });
  }

  static Future<bool> _createUser(String email, String password) async {
    return await _authenticator.createUserWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) { return true; })
        .catchError((Error e) { return false; });
  }

  //User Exists
  //-------------------------------------------------------------------------------------------

  static bool userAlreadyExists(String email) {
    _fetchEmailProviders(email).then((providers) { return providers.isNotEmpty; });
  }

  static Future<List<String>> _fetchEmailProviders(String email) async {
    return await _authenticator.fetchProvidersForEmail(email: email);
  }

}