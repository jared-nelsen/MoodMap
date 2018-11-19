
import 'package:flutter/material.dart';

import 'package:mood_map/components/ratable_emotion_list_item.dart';

import 'package:mood_map/common/emotion.dart';
import 'package:mood_map/application/emotion_context.dart';
import 'package:mood_map/common/emotion_rating.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/application/app_navigator.dart';

import 'package:after_layout/after_layout.dart';

import 'package:mood_map/emotions/emotion_deletion.dart';

class EmotionsQuickRateView extends StatefulWidget {

  EmotionContext _emotionContext;

  EmotionsQuickRateView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new EmotionsQuickRateViewState(this._emotionContext);
}

class EmotionsQuickRateViewState extends State<EmotionsQuickRateView> {

  DatabaseReference _allEmotionsFirebase = Database.emotionsReference();

  EmotionContext _emotionContext;

  List<RatableEmotionListItem> _ratingEmotions = new List();

  final GlobalKey<FormState> _addEmotionFormKey = new GlobalKey<FormState>();
  String _emotionToAdd = "";

  EmotionsQuickRateViewState(_emotionContext){
    this._emotionContext = _emotionContext;

    _allEmotionsFirebase.onChildAdded.listen(_retrieveAllEmotionsFromDatabase);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Rating My Emotions..."),
      ),

      body: new ListView(
        children: _ratingEmotions
      ),

      persistentFooterButtons: <Widget>[

        new FlatButton(onPressed: (){ _saveRatingsToDatabase(); },
          child: new Text("Rate"),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),),

        new FlatButton(onPressed: (){ _saveRatingsToDatabase(); AppNavigator.navigateToMakeJournalView(); },
          child: new Text("Rate and Journal"),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),),

        new FlatButton(onPressed: (){ _emotionContext.navigateBackToSpecifics(); },
          child: new Text("Back", style: new TextStyle(color: Colors.red),),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),)

      ],

      floatingActionButton: FloatingActionButton.extended(
          onPressed: _addEmotion,
          icon: new Icon(Icons.add),
          label: new Text("New Emotion")),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }

  void _saveRatingsToDatabase() {

    setState(() {

      for(var ratingItem in _ratingEmotions) {

        var ref = Database.emotionRatingPushReference();

        EmotionRating rating = new EmotionRating(
            ratingItem.getDBKey(),
            "General",
            "General",
            ratingItem.getEmotion(),
            ratingItem.getRating());

        ref.set(rating.toJson());

      }

    });

    Utilities.showSnackbarMessage(context, "Emotions rated successfully");

    //We are done with the workflow so navigate back to the categories
    _emotionContext.navigateBackToCategories();

  }

  void _retrieveAllEmotionsFromDatabase(Event event) {

    setState(() {

      Emotion emotion = Emotion.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _ratingEmotions) {
        if(listItem.getEmotion() == emotion.getEmotion()) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _addEmotionToRatingList(emotion);
      }

    });

  }

  void _addEmotionToRatingList(Emotion emotion) {

    final newList = new List<RatableEmotionListItem>.from(_ratingEmotions)
      ..add(new RatableEmotionListItem(
        dbKey: emotion.getDbKey(),
        category: emotion.getCategory(),
        specific: emotion.getSpecific(),
        emotion: emotion.getEmotion(),
        deletionCallback: _deleteEmotionRatingItem,
      ));

    setState(() {
      _ratingEmotions = newList;
    });

  }

  Future<Null> _addEmotion() async {

    await showDialog(

      context: context,

      child: new Form(
        key: _addEmotionFormKey,
        child: new SimpleDialog(

          title: new Text("Add a new emotion"),

          children: <Widget>[

            new Padding(

              padding: const EdgeInsets.all(10.0),

              child: new TextFormField(

                decoration: new InputDecoration(

                    hintText: "Emotion Name",

                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
                        borderSide: new BorderSide(color: Colors.black, width: 1.0)
                    )

                ),

                autofocus: true,

                validator: (value){

                  _emotionToAdd = value;

                  if(value.isEmpty || value == null) {
                    return "Please enter a name for the emotion";
                  }

                },
              ),

            ),

            new Row(

              children: <Widget>[
                new Expanded(

                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[

                      new FlatButton(
                          child: new Text("Add", style: new TextStyle(color: Colors.green,),),
                          onPressed: (){
                            if(_addEmotionFormKey.currentState.validate()) {
                              _addNewEmotion(_emotionToAdd);
                            }
                          }
                      )
                    ],

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

        ),
      ),

    );
  }

  void _addNewEmotion(String emotionToAdd) {

    //Check to see if we dont already have it in the database which is mirrored with the data in the app
    for(var item in _ratingEmotions) {
      if(item.getEmotion() == emotionToAdd){
        Navigator.pop(context, null);
        return;
      }
    }

    setState(() {

      _addEmotionToDatabase(emotionToAdd);

      Navigator.pop(context, null);
    });

  }

  void _addEmotionToDatabase(String emotionToAdd) {

    setState(() {

      var ref = Database.emotionsPushReference();

      Emotion emotion = new Emotion("General", "General", emotionToAdd);

      ref.set(emotion.toJson());

    });

  }


  void _deleteEmotionRatingItem(String emotion) async {

    await showDialog(context: context,
        builder: (BuildContext context) {

          return new SimpleDialog(
            title: new Text("Are you sure you would like to delete the $emotion emotion under this context?\n\n"
                "All emotion rating data associated with this emotion will also be deleted."),
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
                            for(int i = 0; i < _ratingEmotions.length; i++) {
                              RatableEmotionListItem item = _ratingEmotions.elementAt(i);
                              if(emotion == item.getEmotion()) {
                                index = i;
                                break;
                              }
                            }

                            //Remove from the database
                            EmotionDeletionModule.deleteEmotion(emotion);

                            //Remove from the list
                            _ratingEmotions.removeAt(index);

                            _confirm("The $emotion emotion and all associated data has been removed");

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

}