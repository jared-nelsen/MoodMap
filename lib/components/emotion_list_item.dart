
import 'package:flutter/material.dart';

class EmotionListItem extends StatefulWidget {

  String _title = "";
  bool _isSelected = false;

  EmotionListItem(this._title);

  @override
  State<StatefulWidget> createState() => new EmotionListItemState(_title);
}

class EmotionListItemState extends State<EmotionListItem> {

  String _title = "";
  bool _isSelected = false;

  EmotionListItemState(this._title);

  @override
  Widget build(BuildContext context) {

    return new CheckboxListTile(

      title: new Text(_title),
      value: _isSelected,
      onChanged: (bool value) {
        setState(() {
          _isSelected = value;
        });
      },

    );

  }

  String getTitle() {
    return _title;
  }

  bool isSelected() {
    return _isSelected;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}