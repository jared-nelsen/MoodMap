
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

import 'views/app_shell.dart';

final googleSignIn = new GoogleSignIn();

void main(){
  runApp(new MaterialApp(
    home: new ApplicationShell(),
    theme: new ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.green,
    ),
  ));
}