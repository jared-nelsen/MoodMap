
import 'package:flutter/material.dart';


class ManageEmotionListItem extends StatelessWidget {

  String _emotionName = "Test";
  bool _tracking = false;

  ManageEmotionListItem(this._emotionName, this._tracking);

  @override
  Widget build(BuildContext context) {

    return new Row(

      children: <Widget>[
        new Flexible (
            child: new Container(
              color: Colors.yellow,
              child: new Row (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  ///The name of the emotion
                  new Column(
                    children: <Widget>[
                      new Text(_emotionName),
                    ],
                  ),

                  ///The switch to track the emotion or not
                  new Column(
                    children: <Widget>[
                      new Switch(value: _tracking, onChanged: switchChanged),
                    ],
                  ),

                ],
              ),
            )
        )
      ],
    );

  }

  void switchChanged(bool) {
    if(_tracking == true) {
      _tracking = false;
    } else {
      _tracking = true;
    }
  }

}