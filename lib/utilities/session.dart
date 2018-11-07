import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/application/app_navigator.dart';

class Session {

  static final FirebaseAuth _authenticator = FirebaseAuth.instance;

  //Get User
  //-------------------------------------------------------------------------------------------

  static Future<FirebaseUser> getCurrentUser() async {
    return await _authenticator.currentUser();
  }

  //Login
  //-------------------------------------------------------------------------------------------

  static void login(BuildContext context, String email, String password) async {

    email = email.trim();
    password = password.trim();

    //Check if the user already exists
    await _checkUserAlreadyExists(email).then((exists) {

      if(exists) {

        _authenticator.signInWithEmailAndPassword(email: email, password: password)
            .then((FirebaseUser user) { _loginSuccess(); })
            .catchError((Error e) { _loginFailure(context); });

      } else {

        Utilities.showMessageDialog(context, "That user doesn't exist. Please create an account below.");

      }

    });

  }

  static void _loginSuccess() {
    AppNavigator.navigateToApplicationShell();
  }

  static void _loginFailure(BuildContext context) {
    Utilities.showMessageDialog(context, "Login failed. Please check your network connection.");
  }

  //Create User
  //-------------------------------------------------------------------------------------------

  static Future createUserAccount(BuildContext context, email, String password) async {

    //Check if the user already exists
    await _checkUserAlreadyExists(email).then((exists) {

      if(exists) {

        Utilities.showMessageDialog(context, "That user already exists. Please login or select another account.");
        AppNavigator.navigateToLoginScreen();

      } else {

        _authenticator.createUserWithEmailAndPassword(email: email, password: password)
            .then((FirebaseUser user) { _createUserSuccess(); })
            .catchError((Error e) { _createUserFailure(context); });

      }

    });

  }

  static void _createUserSuccess() {
    AppNavigator.navigateToApplicationShell();
  }

  static void _createUserFailure(BuildContext context) {
    Utilities.showMessageDialog(context, "User creation failed. Please check your network connection.");
  }

  //User Exists
  //-------------------------------------------------------------------------------------------

  static Future<bool> _checkUserAlreadyExists(String email) async {

    email = email.trim();

    return await _fetchEmailProviders(email).then((providers) {

      if(providers.isNotEmpty) {
        return true;
      } else {
        return false;
      }

    });

  }

  static Future<List<String>> _fetchEmailProviders(String email) async {
    return await _authenticator.fetchProvidersForEmail(email: email);
  }

}