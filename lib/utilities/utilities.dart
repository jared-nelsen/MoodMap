
import 'dart:async';

import 'package:flutter/material.dart';

class Utilities {

  static Future<Null> showMessageDialog(BuildContext context, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {

          return new SimpleDialog(
            title: new Text(message),

            children: <Widget>[
              new SimpleDialogOption(
                child: new Text("OK"),
                onPressed: () { Navigator.pop(context); },
              )
            ],

          );
        });
  }

  static bool isEmail(String test) {

    String emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(emailRegex);

    return regExp.hasMatch(test);
  }

}