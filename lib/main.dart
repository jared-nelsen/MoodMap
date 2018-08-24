
import 'package:flutter/material.dart';

import 'application/app_view_controller.dart';
import 'package:mood_map/views/view_controller.dart';

void main(){
  runApp(new MaterialApp(
    home: new AppViewController(),
    theme: new ThemeData(
      primaryColor: Colors.blue,
      accentColor: Colors.green,
    ),
  ));
}