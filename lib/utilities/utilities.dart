
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

  //Time strings come in the form: "10:00 AM"
  static int calculateMinutesFromTimeString(String input) {

    String ampmString = input.substring(input.length - 2, input.length - 1);

    String timeString = "";
    int minutes, hours;
    String minutesString = "";

    //i.e 10:00 AM
    if(input.length == 8) {
      //10:00 - first five characters
      timeString = input.substring(0, 4);
      hours = int.tryParse(timeString.substring(0, 1));
      minutesString = timeString.substring(3, 4);
    }
    //i.e 9:00 AM
    else {
      //9:00 - first four characters
      timeString = input.substring(0, 3);
      hours = int.tryParse(timeString.substring(0, 0));
      minutesString = timeString.substring(2, 3);
    }

    if(ampmString == "PM"){
      hours += 12;
    }

    if(minutesString.substring(0, 1) == "0") {
      minutesString = minutesString.substring(1);
    }

    minutes = int.tryParse(minutesString);

    minutes += hours * 60;

    return minutes;
  }

  static int minuteInADayOutOfNDaysInMinutes(int nDays) {
    return nDays % 1440;
  }

  //Takes a max of the total minutes in a day: 1440
  static String formTimeStringFromMinutesInADay(int minutes) {

    int hours = (minutes / 60).toInt();

    int remainingMinutes = minutes % 60;

    StringBuffer buffer = new StringBuffer();

    buffer.write(hours);
    buffer.write(":");
    if(remainingMinutes == 0) {
      buffer.write("00");
    } else if(remainingMinutes > 0 && remainingMinutes < 10) {
      buffer.write("0");
      buffer.write(remainingMinutes);
    } else {
      buffer.write(remainingMinutes);
    }
    buffer.write(" ");

    if(minutes < 720) {
      buffer.write("AM");
    } else {
      buffer.write("PM");
    }

    return buffer.toString();
  }

  //Returns a string of the form "6 hours and 34 minutes"
  static String formHoursAndMinutesStringFromMinutes(int minutes) {

    int hours = (minutes / 60).toInt();

    int remainingMinutes = minutes % 60;

    StringBuffer buffer = new StringBuffer();

    if(hours == 0) {
      buffer.write(remainingMinutes);
      buffer.write(" minutes");
      return buffer.toString();
    }

    buffer.write(hours);
    buffer.write(" hours and ");
    buffer.write(remainingMinutes);
    buffer.write(" minutes");

    return buffer.toString();
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

  static int randomIntInARange(int min, int max) {

    var random = new Random();

    return min + random.nextInt(max - min);
  }

}