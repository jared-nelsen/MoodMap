
import 'package:flutter/material.dart';

class RateEmotionListItem extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RateEmotionListItemState();

}

class RateEmotionListItemState extends State<RateEmotionListItem> {

  String _emotionName = "Test";

  List<int> _ratings = new List();

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

                ///The Rating mechanism
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    new DropdownButton(
                        items: _ratings.map((int rating){
                          return new DropdownMenuItem(value: rating);
                        }).toList(),
                    )

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
    _ratings.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}