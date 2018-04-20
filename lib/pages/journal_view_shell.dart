
import 'package:flutter/material.dart';

class JournalView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new JournalViewState();

}

class JournalViewState extends State<JournalView> {

  ///The list of emotion widgets that are controllable in the list view
  //List<ManageEmotionListItem> _emotionWidgets = new List();

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
                              child: new Text("Journal Entries",
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0
                                ),
                              ),
                            )
                          ],
                        ),

                        ///Rating Column Title
                        new Column(
                          children: <Widget>[
                            new Container(
                              color: Colors.redAccent,
                              padding: const EdgeInsets.all(10.0),
                              child: new Text("Rate",
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

                  ///Confirm Rating Button
                  new FloatingActionButton(
                    onPressed: null,
                    child: new Icon(Icons.check),
                    elevation: 15.0,
                  )


                ],
              )
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