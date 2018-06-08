
import 'package:flutter/material.dart';

class EmotionListItem extends StatelessWidget {

  final String title;

  EmotionListItem(this.title);

  @override
  Widget build(BuildContext context) {

    return new ListTile(

        title: new Text(title),

    );

  }

  String getTitle() {
    return title;
  }

}