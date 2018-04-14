import 'package:flutter/material.dart';

import 'package:mood_map/components/manage_emotion_list_item.dart';

class ManageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageViewState();

}

class ManageViewState extends State<ManageView> {

  ///The list of emotion widgets that are controllable in the list view
  List<ManageEmotionListItem> _emotionWidgets = new List();

  @override
  Widget build(BuildContext context) {

    ///Top level container for the manage emotion view
    return new Container(
      color: Colors.green,

      ///The row in the container containing the elements in the view
      child: new Row(
        children: <Widget>[
          new Expanded(

              ///The page title
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(10.0),
                    child: new Text("Manage Emotions",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  ///Title Info Bar
                  new Container(
                    decoration: new BoxDecoration(
                      color: Colors.redAccent,
                      border: new Border.all(color: Colors.black),
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        ///Emotion Column Title
                        new Column(
                          children: <Widget>[
                            new Container(
                              color: Colors.redAccent,
                              padding: const EdgeInsets.all(10.0),
                              child: new Text("Emotion",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0
                                ),
                              ),
                            )
                          ],
                        ),

                        ///Tracking Column Title
                        new Column(
                          children: <Widget>[
                            new Container(
                              color: Colors.redAccent,
                              padding: const EdgeInsets.all(10.0),
                              child: new Text("Tracking",
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),


                  //new ListView.builder(itemBuilder: null),

                  ///The add emotion button
                  new FloatingActionButton(
                    onPressed: null,
                    child: new Icon(Icons.add),
                    elevation: 15.0,
                  )


                ],
              )
          )
        ],
      ),
    );

  }

  void removeEmotion(ManageEmotionListItem item) {
    _emotionWidgets.remove(item);
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
