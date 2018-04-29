
import 'package:flutter/material.dart';

import 'package:mood_map/components/navigable_list_item.dart';

class RateSpecificsView extends StatefulWidget {

  Function _navigateToCategories;
  Function _navigateToEmotions;

  RateSpecificsView(this._navigateToCategories, this._navigateToEmotions);

  @override
  State<StatefulWidget> createState() => new RateSpecificsViewState(this._navigateToCategories, this._navigateToEmotions);

}

class RateSpecificsViewState extends State<RateSpecificsView> {

  Function _navigateToCategories;
  Function _navigateToEmotions;

  List<NavigableListItem> _specifics = new List();

  RateSpecificsViewState(this._navigateToCategories, this._navigateToEmotions);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(

        appBar: new AppBar(title: new Text("More specifically"),),

        body: new ListView(
            children: _specifics.map((NavigableListItem specific) {
              return specific;
            }).toList()
        ),


        floatingActionButton: new FloatingActionButton(
          onPressed: addSpecific,
          child: new Icon(Icons.add),
        ),

        persistentFooterButtons: <Widget>[
          new FlatButton(onPressed: _navigateToCategories, child: new Text("Back"))
        ],

      ),
    );
  }

  void addSpecific() {
    setState(() {
      _specifics.add(new NavigableListItem("Sarah", _navigateToEmotions));
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