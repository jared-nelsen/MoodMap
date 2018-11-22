
import 'dart:async';
import 'dart:math';

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

  static String formatDateNamedMonth(String date) {

    StringBuffer formatted = new StringBuffer();

    var numeralsToMonths = {
      "1": "January",
      "2": "February",
      "3": "March",
      "4": "April",
      "5": "May",
      "6": "June",
      "7": "July",
      "8": "August",
      "9": "September",
      "10": "October",
      "11": "November",
      "12": "December",
    };

    List<String> parts = date.split('/');


    formatted.write(numeralsToMonths[parts.elementAt(0)]);
    formatted.write(" ");
    formatted.write(parts.elementAt(1));
    int day = int.parse(parts.elementAt(1));
    switch(day) {
      case 1:
      case 21:
      case 31:
        formatted.write("st");
        break;
      case 2:
      case 22:
        formatted.write("nd");
        break;
      case 3:
      case 23:
        formatted.write("rd");
        break;
      case 4:
      case 24:
        formatted.write("th");
    }

    formatted.write(", ");
    formatted.write(parts.elementAt(2));

    return formatted.toString();
  }

  static void showSnackbarMessage(BuildContext context, String confirmation) {
    Scaffold.of(context).showSnackBar(SnackBar(content: new Text(confirmation), duration: new Duration(seconds: 2),));
  }

  static void showPageInfoSnackbarMessage(BuildContext context, String message) {

    if(oneInXChance(3)){
      Scaffold.of(context).showSnackBar(SnackBar(content: new Text(message), duration: new Duration(seconds: 1),));
    }

  }

  static bool oneInXChance(int x) {

    Random random = new Random();

    int chance = random.nextInt(x);

    if(chance == x - 1) {
      return true;
    }

    return false;
  }

}