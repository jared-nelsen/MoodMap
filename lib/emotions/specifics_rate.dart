
import 'package:flutter/material.dart';
import 'dart:async';

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

  String toAdd;

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
          onPressed: _addSpecific,
          child: new Icon(Icons.add),
        ),

        persistentFooterButtons: <Widget>[
          new FlatButton(onPressed: _navigateToCategories, child: new Text("Back"))
        ],

      ),
    );
  }

  Future<Null> _addSpecific() async {
    await showDialog(
        context: context,
        child: new SimpleDialog(
          title: new Text("Add some specifics"),
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new TextField(
                decoration: new InputDecoration(
                    hintText: "Add some specifics",
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
                        borderSide: new BorderSide(color: Colors.black, width: 1.0)
                    )
                ),
                autofocus: true,
                maxLengthEnforced: true,
                onChanged: (String text) {toAdd = text;},
              ),),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new FlatButton(
                          child: new Text("Add", style: new TextStyle(color: Colors.green,),),
                          onPressed: () {
                            if(toAdd.isNotEmpty) {
                              setState(() {
                               // _specifics.add(new NavigableListItem(toAdd, _navigateToEmotions));
                                Navigator.pop(context, null);
                              });}
                          }
                      )],
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                        child: new Text("Cancel"),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context, null);
                          });})
                  ],
                )
              ],
            )
          ],
        )
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