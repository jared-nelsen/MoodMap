
import 'package:flutter/material.dart';

import 'pages/app_shell.dart';


void main(){
  runApp(new MaterialApp(
    home: new ApplicationShell(),
    theme: new ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.green,
      accentColor: Colors.blueAccent
    ),
  ));
}