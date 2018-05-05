
import 'package:flutter/material.dart';

class NavigableListItem extends StatefulWidget {

  String _title;
  Function _navigationFunction;

  NavigableListItem(this._title, this._navigationFunction);

  @override
  State<StatefulWidget> createState() => new NavigableListItemState(this._title, this._navigationFunction);

}

class NavigableListItemState extends State<NavigableListItem> {

  String _title;
  Function _navigationFunction;

  NavigableListItemState(this._title, this._navigationFunction);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_title, style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: _navigationFunction,
          child: new Icon(Icons.arrow_forward)),
    );
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