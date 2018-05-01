
import 'package:flutter/material.dart';

class EmotionListItem extends StatelessWidget {

  final String title;
  final bool selected;
  final ValueChanged<bool> onChange;

  EmotionListItem({this.title, this.selected, this.onChange});

  @override
  Widget build(BuildContext context) {

    return new CheckboxListTile(

      title: new Text(title),
      value: selected,
      onChanged: onChange

    );

  }

  String getTitle() {
    return title;
  }

  bool isSelected() {
    return selected;
  }

  ValueChanged<bool> onChanged() {
    return onChange;
  }

}