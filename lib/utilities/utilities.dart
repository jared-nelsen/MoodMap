
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

}