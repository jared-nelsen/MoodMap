
import 'package:flutter/material.dart';

import 'package:mood_map/components/navigable_list_item.dart';

class RateCategoriesView extends StatefulWidget {

  Function _navigateToSpecifics;

  RateCategoriesView(this._navigateToSpecifics);

  @override
  State<StatefulWidget> createState() => new RateCategoriesViewState(_navigateToSpecifics);

}

class RateCategoriesViewState extends State<RateCategoriesView> {

  Function _navigateToSpecifics;

  List<NavigableListItem> _emotions = new List();

  RateCategoriesViewState(this._navigateToSpecifics);

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        appBar: new AppBar(title: new Text("Rate My Emotions With..."),),

        body: new ListView(
          children: _emotions.map((NavigableListItem emotion) {
            return emotion;
          }).toList()
        ),

        floatingActionButton: new FloatingActionButton(
          onPressed: addEmotion,
          child: new Icon(Icons.add),
        ),

      ),

    );

  }

  void addEmotion() {
    setState(() {
      _emotions.add(new NavigableListItem("Anger", _navigateToSpecifics));
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
