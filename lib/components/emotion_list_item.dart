
import 'package:flutter/material.dart';

class EmotionListItem extends StatelessWidget {

  final String dbKey;

  final String category;
  final String specific;
  final String emotion;

  final bool selected;

  final ValueChanged<bool> onChange;

  EmotionListItem({this.dbKey, this.category, this.specific, this.emotion, this.selected, this.onChange});

  @override
  Widget build(BuildContext context) {

    return new CheckboxListTile(

      title: new Text(emotion),
      value: selected,
      onChanged: onChange

    );

  }

  String getDBKey() {
    return dbKey;
  }

  String getCategory() {
    return category;
  }

  String getSpecific() {
    return specific;
  }

  String getEmotion() {
    return emotion;
  }

  bool isSelected() {
    return selected;
  }

  ValueChanged<bool> onChanged() {
    return onChange;
  }

}