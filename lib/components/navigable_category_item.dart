
import 'package:flutter/material.dart';

import 'package:mood_map/components/emotion_context.dart';

class NavigableCategoryItem extends StatefulWidget {

  String dbKey;

  String _category;

  EmotionContext _emotionContext;

  NavigableCategoryItem(this.dbKey, this._category, this._emotionContext);

  @override
  State<StatefulWidget> createState() => new NavigableCategoryState(this._category, this._emotionContext);

}

class NavigableCategoryState extends State<NavigableCategoryItem> {

  String _category = "";

  EmotionContext _emotionContext;

  NavigableCategoryState(this._category, this._emotionContext);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_category, style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _emotionContext.setAndNavigateCategory(_category); },
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