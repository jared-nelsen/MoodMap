
import 'package:flutter/material.dart';

class RateEmotionListItem extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RateEmotionListItemState();

}

class RateEmotionListItemState extends State<RateEmotionListItem> {

  String _emotionName = "Test";

  @override
  Widget build(BuildContext context) {

    ///The top level container for the emotion entry
    return new Container(
      color: Colors.yellow,
      child: new Row(
        children: <Widget>[
          new Expanded(

            ///The spanning column in the row
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                ///The name of the emotion
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Text(_emotionName),
                  ],
                ),

                ///The switch to track the emotion or not
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                  ],
                ),


              ],
            ),
          )
        ],
      ),
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