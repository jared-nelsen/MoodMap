import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/common/user_data.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';
import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/application/app_navigator.dart';
import 'package:mood_map/utilities/initial_data.dart';

class Session {

  static final FirebaseAuth _authenticator = FirebaseAuth.instance;

  static final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  static String _resetEmail;

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
    await _checkUserAlreadyExists(email).then((exists) async {

      if(exists) {

        await _authenticator.signInWithEmailAndPassword(email: email, password: password)
                .then((FirebaseUser user) { _loginSuccess(context); })
                .catchError((Error e) { _loginFailure(context); });

      } else {

        _userDoesntExist(context);

      }

    });

  }

  static void _loginSuccess(BuildContext context) {
    AppNavigator.navigateToApplicationShell();
    Utilities.showSnackbarMessage(context, "Successfully logged in");
  }

  static void _loginFailure(BuildContext context) {
    Utilities.showMessageDialog(context, "Login failed. Please check your network connection.");
  }

  //Create User
  //-------------------------------------------------------------------------------------------

  static Future createUserAccount(BuildContext context, String email, String password) async {

    //Check if the user already exists
    await _checkUserAlreadyExists(email).then((exists) async {

      if(exists) {

        _userAlreadyExists(context);

        AppNavigator.navigateToLoginScreen();

      } else {

        FirstTimeDataUploader.uploadRandomDevelopmentRatingData();

        await _authenticator.createUserWithEmailAndPassword(email: email, password: password)
              .then((FirebaseUser user)  {

                FirstTimeDataUploader.uploadUserCreationData().then((nothing) {

                  _saveUserCredentials(user.uid, email).then((nothing) {

                    _createUserSuccess();

                  });

                }).catchError((Error e) { _createUserFailure(context); });

              })
              .catchError((Error e) { _createUserFailure(context); });

      }

    });

  }

  static Future<void> _saveUserCredentials(String userUID, String email) async {

    DatabaseReference userReference = Database.userDataPushReference();

    UserData userData = new UserData(userUID, email, DateTime.now());

    userReference.set(userData.toJson());

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

  static void _userDoesntExist(BuildContext context) {
    Utilities.showSnackbarMessage(context, "That user doesn't exist. Please create an account down here.");
  }

  static void _userAlreadyExists(BuildContext context) {
    Utilities.showSnackbarMessage(context, "That user already exists. Please login or select another account.");
  }

  //Sign Out
  //------------------------------------------------------------------------------------------

  static Future<void> logOut() async {
    AppNavigator.navigateToLoginScreen();
    return _authenticator.signOut();
  }

  //Reset Password
  //------------------------------------------------------------------------------------------

  static void passwordReset(BuildContext context) async {

    await showDialog(

      context: context,

      child: new Form(
        key: _formKey,
        child: new SimpleDialog(

          title: new Text("Send a password reset email to"),

          children: <Widget>[

            new Padding(

              padding: const EdgeInsets.all(10.0),

              child: new TextFormField(

                decoration: new InputDecoration(

                    hintText: "Email Address",

                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
                        borderSide: new BorderSide(color: Colors.black, width: 1.0)
                    )

                ),

                autofocus: true,

                validator: (value) {

                  if(!Utilities.isEmail(value)) {
                    return "Please enter a valid email address";
                  }

                  _resetEmail = value;
                },
              ),

            ),

            new Row(

              children: <Widget>[
                new Expanded(

                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      new FlatButton(
                          child: new Text("Send Reset Email", style: new TextStyle(color: Colors.green,),),
                          onPressed: () async {

                            if(_formKey.currentState.validate()) {

                              await _authenticator.sendPasswordResetEmail(email: _resetEmail)
                              .then((result) {
                                Navigator.pop(context, null);

                                var info = SnackBar(
                                  content: new Text("A Password Reset Email was sent to " + _resetEmail),
                                  duration: new Duration(seconds: 2),);

                                Scaffold.of(context).showSnackBar(info);

                              })
                              .catchError((error) {

                                Navigator.pop(context, null);

                                Utilities.showSnackbarMessage(context, "That user doesn't exist. Please create an account down here.");

                              });

                            }

                          }
                      )
                    ],

                  ),

                ),

                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    new FlatButton(

                        child: new Text("Cancel"),

                        onPressed: () { Navigator.pop(context, null); }

                    )
                  ],
                )
              ],
            )

          ],

        ),
      ),

    );

  }

}