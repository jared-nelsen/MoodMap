
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/common/specific.dart';
import 'package:mood_map/components/navigable_specifics_item.dart';

import 'package:mood_map/application/emotion_context.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';
import 'package:mood_map/utilities/utilities.dart';
import 'package:after_layout/after_layout.dart';

import 'package:mood_map/emotions/emotion_deletion.dart';

class RateSpecificsView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateSpecificsView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateSpecificsViewState(this._emotionContext);

}

class RateSpecificsViewState extends State<RateSpecificsView> with AfterLayoutMixin<RateSpecificsView> {

  DatabaseReference _specificsFirebase = Database.specificsReference();

  EmotionContext _emotionContext;

  List<NavigableSpecificsItem> _specifics = new List();

  String _toAdd = "";

  RateSpecificsViewState(EmotionContext context) {
    this._emotionContext = context;

    //Listen to changes from the database
    _specificsFirebase.onChildAdded.listen(_retrieveFromDatabase);
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

        floatingActionButton: FloatingActionButton.extended(
            onPressed: _addSpecific,
            icon: new Icon(Icons.add),
            label: new Text("Add some specifics to " + _emotionContext.getCategory())),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        persistentFooterButtons: <Widget>[
          new FlatButton(
              onPressed: (){ _emotionContext.navigateBackToCategories(); },
              child: new Text("Back", style: new TextStyle(color: Colors.red),),
              padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          )
        ],

      ),
    );

  }

  @override
  void afterFirstLayout(BuildContext context) {
    Utilities.showPageInfoSnackbarMessage(context, "You can long press a specifics item to remove it");
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

      var ref = Database.specificsPushReference();

      SpecificsItem item = new SpecificsItem(_emotionContext.getCategory(), _toAdd);

      ref.set(item.toJson());

      Navigator.pop(context, null);

      Utilities.showSnackbarMessage(context, "Specifics added successfully");
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
        _specifics.add(new NavigableSpecificsItem(item.key, item.getSpecific(), _emotionContext, _deleteSpecifics));
      }

    });

  }

  void _deleteSpecifics(String specific) async {

    await showDialog(context: context,
        builder: (BuildContext context) {

          return new SimpleDialog(
            title: new Text("Are you sure you would like to delete the $specific specific section "
                "from the ${_emotionContext.getCategory()} category?\n\n"
                "All Specific Emotions, and Emotion rating data associated with this this Specific "
                "will also be deleted."),
            children: <Widget>[

              new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      new SimpleDialogOption(
                        child: const Text("Yes", style: const TextStyle(color: Colors.green),),
                        onPressed: (){

                          setState(() {
                            int index = 0;
                            for(int i = 0; i < _specifics.length; i++) {
                              NavigableSpecificsItem item = _specifics.elementAt(i);
                              if(specific == item.getSpecific()) {
                                index = i;
                                break;
                              }
                            }

                            //Remove from the database
                            EmotionDeletionModule.deleteSpecific(specific);

                            //Remove from the list
                            _specifics.removeAt(index);

                            _confirm("The $specific specific section and all associated data has been removed");

                          });

                          Navigator.pop(context);
                        },
                      ),
                      new SimpleDialogOption(
                        child: const Text("No"),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )

                    ],
                  )
                ],
              )

            ],
          );
        }
    );

  }

  void _confirm(String message) {
    Utilities.showSnackbarMessage(context, message);
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