
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/common/specific.dart';
import 'package:mood_map/components/navigable_specifics_item.dart';

import 'package:mood_map/components/emotion_context.dart';

import 'package:firebase_database/firebase_database.dart';

class RateSpecificsView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateSpecificsView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateSpecificsViewState(this._emotionContext);

}

class RateSpecificsViewState extends State<RateSpecificsView> {

  DatabaseReference firebase = FirebaseDatabase.instance.reference().child("emotion_specifics");

  EmotionContext _emotionContext;

  List<NavigableSpecificsItem> _specifics = new List();

  String _toAdd = "";

  RateSpecificsViewState(EmotionContext context) {
    this._emotionContext = context;

    //Listen to changes from the database
    firebase.onChildAdded.listen(_retrieveFromDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(

        appBar: new AppBar(title: new Text("More specifically..."),),

        body: new ListView(
            children: _specifics.map((NavigableSpecificsItem specific) {
              return specific;
            }).toList()
        ),


        floatingActionButton: new FloatingActionButton(
          onPressed: _addSpecific,
          child: new Icon(Icons.add),
        ),

        persistentFooterButtons: <Widget>[
          new FlatButton(onPressed: (){ _emotionContext.navigateBackToCategories(); }, child: new Text("Back"))
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
                onChanged: (String text) {_toAdd = text;},
              ),),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new FlatButton(
                          child: new Text("Add", style: new TextStyle(color: Colors.green,),),
                          onPressed: _addToDatabase
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

  void _addToDatabase() {

    setState(() {

      var ref = FirebaseDatabase.instance.reference().child("emotion_specifics").push();

      SpecificsItem item = new SpecificsItem(_emotionContext.getCategory(), _toAdd);

      ref.set(item.toJson());

      Navigator.pop(context, null);
    });

  }

  void _retrieveFromDatabase(Event event) {

    setState(() {

      SpecificsItem item = SpecificsItem.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _specifics) {
        if(listItem.dbKey == item.key) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere && item.getCategory() == _emotionContext.getCategory()) {
        _specifics.add(new NavigableSpecificsItem(item.key, item.getSpecific(), _emotionContext));
      }

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