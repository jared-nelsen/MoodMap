
import 'package:flutter/material.dart';

class EmotionListItem extends StatelessWidget {

  final String dbKey;

  final String title;
  final bool selected;
  final ValueChanged<bool> onChange;

  EmotionListItem({this.dbKey, this.title, this.selected, this.onChange});

  @override
  Widget build(BuildContext context) {

    return new CheckboxListTile(

      title: new Text(title),
      value: selected,
      onChanged: onChange

    );

  }

  String getDBKey() {
    return dbKey;
  }

  String getEmotionName() {
    return title;
  }

  bool isSelected() {
    return selected;
  }

  ValueChanged<bool> onChanged() {
    return onChange;
  }

}