
import 'package:flutter/material.dart';

import 'package:mood_map/components/emotion_context.dart';

class NavigableSpecificsItem extends StatefulWidget {

  String dbKey;

  String _specific;

  EmotionContext _emotionContext;

  NavigableSpecificsItem(this.dbKey, this._specific, this._emotionContext);

  @override
  State<StatefulWidget> createState() => new NavigableSpecificsItemState(this._specific, this._emotionContext);

}

class NavigableSpecificsItemState extends State<NavigableSpecificsItem> {

  String _specific;
  EmotionContext _emotionContext;

  NavigableSpecificsItemState(this._specific, this._emotionContext);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(_specific, style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _emotionContext.setAndNavigateSpecific(_specific)},
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