
import 'package:flutter/material.dart';

import '../components/emotion_manage.dart';
import '../components/list_title_bar.dart';

class ManageEmotionsView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageEmotionsViewState();

}

class ManageEmotionsViewState extends State<ManageEmotionsView> {

  ///The list of emotion widgets that are controllable in the list view
  List<ManageEmotionListItem> _emotionWidgets = new List();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body:

        new Container(
          color: Colors.green,

          ///The row in the container containing the elements in the view
          child: new Row(
            children: <Widget>[
              new Expanded(

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


                      new Expanded (
                          child:
                          new ListView(
                            children:
                            _emotionWidgets.map((ManageEmotionListItem item) {
                              return new Container(
                                child: item,
                              );
                            }).toList(),

                          ),
                      ),



                      ///The add emotion button



                    ],
                  )
              )
            ],
          ),
        ),

      floatingActionButton: new FloatingActionButton(
        onPressed: addEmotion,
        child: new Icon(Icons.add),
      ),

    );

  }

  void addEmotion() {
    setState(() {
      _emotionWidgets.add(new ManageEmotionListItem("Test", true));
    });
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