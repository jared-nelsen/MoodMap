
import 'package:flutter/material.dart';

import 'package:mood_map/application/emotion_context.dart';

class NavigableSpecificsItem extends StatefulWidget {

  String dbKey;

  String _specific;

  EmotionContext _emotionContext;

  Function _deletionCallback;

  NavigableSpecificsItem(this.dbKey, this._specific, this._emotionContext, this._deletionCallback);

  @override
  State<StatefulWidget> createState() => new NavigableSpecificsItemState(this._specific, this._emotionContext, this._deletionCallback);

  String getSpecific() {
    return _specific;
  }

}

class NavigableSpecificsItemState extends State<NavigableSpecificsItem> {

  String _specific;
  EmotionContext _emotionContext;

  Function _deletionCallback;

  NavigableSpecificsItemState(this._specific, this._emotionContext, this._deletionCallback);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_specific, style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _emotionContext.setSpecificAndNavigateToEmotions(_specific); },
          child: new Icon(Icons.arrow_forward)),
      onLongPress: () { _deletionCallback(_specific); },
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