import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/application/app_navigator.dart';

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
                .then((FirebaseUser user) { _loginSuccess(); })
                .catchError((Error e) { _loginFailure(context); });

      } else {

        _userDoesntExist(context);

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
    await _checkUserAlreadyExists(email).then((exists) async {

      if(exists) {

        Utilities.showMessageDialog(context, "That user already exists. Please login or select another account.");
        AppNavigator.navigateToLoginScreen();

      } else {

        await _authenticator.createUserWithEmailAndPassword(email: email, password: password)
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

  static void _userDoesntExist(BuildContext context) {
    Utilities.showMessageDialog(context, "That user doesn't exist. Please create an account below.");
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

                                var info = SnackBar(content: new Text("A Password Reset Email was sent to " + _resetEmail),);
                                Scaffold.of(context).showSnackBar(info);

                              })
                              .catchError((error) {

                                Navigator.pop(context, null);

                                var info = SnackBar(content: new Text("That user doesn't exist. Please create an account above."),);
                                Scaffold.of(context).showSnackBar(info);

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