
import 'package:flutter/material.dart';

import 'package:mood_map/application/emotion_context.dart';

class NavigableCategoryItem extends StatefulWidget {

  String dbKey;

  String _category;

  EmotionContext _emotionContext;

  Function _deletionCallback;

  NavigableCategoryItem(this.dbKey, this._category, this._emotionContext, this._deletionCallback);

  @override
  State<StatefulWidget> createState() => new NavigableCategoryState(this._category, this._emotionContext, this._deletionCallback);

  String getCategory() {
    return _category;
  }

  String getDbKey() {
    return dbKey;
  }

}

class NavigableCategoryState extends State<NavigableCategoryItem> {

  String _category;

  EmotionContext _emotionContext;

  Function _deletionCallback;

  NavigableCategoryState(this._category, this._emotionContext, this._deletionCallback);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_category, style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _emotionContext.setCategoryAndNavigateToSpecifics(_category); },
          child: new Icon(Icons.arrow_forward)),
      onLongPress: () { _deletionCallback(_category); },
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