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
    return new Container(
      color: Colors.green,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(10.0),
                    child: new Text("Manage Emotions", style:
                              new TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                    ),
                  ),
                  //new ListView.builder(itemBuilder: null),
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
