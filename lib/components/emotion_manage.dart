
import 'package:flutter/material.dart';


class ManageEmotionListItem extends StatelessWidget {

  String _emotionName = "Test";
  bool _tracking = false;

  ManageEmotionListItem(this._emotionName, this._tracking);

  @override
  Widget build(BuildContext context) {

//    return new ListTile(
//      leading: new Text(_emotionName),
//    );

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Flexible (
            child: new Container(
              color: Colors.yellow,
              child: new Row (
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

//    ///The top level container for the emotion entry
//    return new Padding (
//      padding: EdgeInsets.all(10.0),
//      child: new Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//
//          new Container(
//            color: Colors.yellow,
//            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//
//                  ///The name of the emotion
//                  new Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      new Text(_emotionName),
//                    ],
//                  ),
//
//                  ///The switch to track the emotion or not
//                  new Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      new Switch(value: _tracking, onChanged: switchChanged),
//                    ],
//                  ),
//
//              ],
//            ),
//
//          )
//        ],
//      )
//
//    );

//
//      child: new Row(
//        children: <Widget>[
//          new Container(
//
//              child: new Row(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//
//                  ///The name of the emotion
//                  new Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      new Text(_emotionName),
//                    ],
//                  ),
//
//                  ///The switch to track the emotion or not
//                  new Column(
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
//                    children: <Widget>[
//                      new Switch(value: _tracking, onChanged: switchChanged),
//                    ],
//                  ),
//
//                ],
//              ),
//            ),
//
//        ],
//      ),
//    )



  }

  void switchChanged(bool) {
    if(_tracking == true) {
      _tracking = false;
    } else {
      _tracking = true;
    }
  }

}