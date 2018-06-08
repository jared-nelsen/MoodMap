
import 'package:flutter/material.dart';

class SleepListItem extends StatelessWidget {

  final String date;

  SleepListItem(this.date);

  @override
  Widget build(BuildContext context) {

    return new ListTile(

        title: new Text(date),

    );

  }

  String getdate() {
    return date;
  }

}