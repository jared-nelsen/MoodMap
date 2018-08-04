
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/common/category.dart';
import 'package:mood_map/components/navigable_category_item.dart';
import 'package:mood_map/components/emotion_context.dart';

import 'package:firebase_database/firebase_database.dart';

class RateCategoriesView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateCategoriesView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateCategoriesViewState(_emotionContext);

}

class RateCategoriesViewState extends State<RateCategoriesView> {

  DatabaseReference firebase = FirebaseDatabase.instance.reference().child("emotion_categories");

  EmotionContext _emotionContext;

  List<NavigableCategoryItem> _emotions = new List();

  String _toAdd = "";

  RateCategoriesViewState(EmotionContext context){
    this._emotionContext = context;

    firebase.onChildAdded.listen(_retrieveFromDatabase);
  }

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        appBar: new AppBar(title: new Text("Rate My Emotions With..."),),

        body: new ListView(
          children: _emotions.map((NavigableCategoryItem emotion) {
            return emotion;
          }).toList()
        ),

        floatingActionButton: new FloatingActionButton(
          onPressed: _addCategory,
          child: new Icon(Icons.add),
        ),

      ),

    );

  }

  Future<Null> _addCategory() async {

    await showDialog(

      context: context,

      child: new SimpleDialog(
        title: new Text("Add a category"),
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new TextField(
                decoration: new InputDecoration(
                    hintText: "Add a new category",
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

      var ref = FirebaseDatabase.instance.reference().child("emotion_categories").push();

      CategoryItem item = new CategoryItem(_toAdd);

      ref.set(item.toJson());

      Navigator.pop(context, null);
    });

  }

  void _retrieveFromDatabase(Event event) {

    setState(() {

      CategoryItem item = CategoryItem.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _emotions) {
        if(listItem.dbKey == item.key) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _emotions.add(new NavigableCategoryItem(item.key, item.getCategory(), _emotionContext));
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
