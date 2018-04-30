
import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/material.dart';

import 'views/app_shell.dart';

final googleSignIn = new GoogleSignIn();
final analytics = new FirebaseAnalytics();

void main(){
  runApp(new MaterialApp(
    home: new ApplicationShell(),
    theme: new ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.green,
    ),
  ));
}