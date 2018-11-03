
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Session {

  static final FirebaseAuth _authenticator = FirebaseAuth.instance;

  //Get User
  //-------------------------------------------------------------------------------------------
  static FirebaseUser getCurrentUser() {

    FirebaseUser currentUser;

    _getCurrentUser().then((FirebaseUser user) { currentUser = user; });

    return currentUser;
  }

  static Future<FirebaseUser> _getCurrentUser() async {
    return await _authenticator.currentUser();
  }

  static String getUUID() {
    return getCurrentUser().uid;
  }

  //Login
  //-------------------------------------------------------------------------------------------

  static bool login(String email, String password) {

    bool loginSuccess = false;

    _login(email, password).then((bool success) { loginSuccess = success; });

    return loginSuccess;
  }

  static Future<bool> _login(String email, String password) async {
    return await _authenticator.signInWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) { return true; })
        .catchError((Error e) { return false; });
  }

  //Create User
  //-------------------------------------------------------------------------------------------

  static bool createUser(String email, String password) {

    bool userCreated = false;

    _createUser(email, password).then((bool success) { userCreated = success; });

    return userCreated;
  }

  static Future<bool> _createUser(String email, String password) async {
    return await _authenticator.createUserWithEmailAndPassword(email: email, password: password)
        .then((FirebaseUser user) { return true; })
        .catchError((Error e) { return false; });
  }

  //User Exists
  //-------------------------------------------------------------------------------------------

  static bool userAlreadyExists(String email) {

    bool alreadyExists = false;

    _userAlreadyExists(email).then((bool exists) { alreadyExists = exists; });

    return alreadyExists;
  }

  static Future<bool> _userAlreadyExists(String email) async {
    return await _fetchEmailProviders(email).then((providers) { return providers.isNotEmpty; });
  }

  static Future<List<String>> _fetchEmailProviders(String email) async {
    return await _authenticator.fetchProvidersForEmail(email: email);
  }

}