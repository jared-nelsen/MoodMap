
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/components/ratable_emotion_list_item.dart';
import 'package:mood_map/components/emotion_list_item.dart';

import 'package:mood_map/common/emotion.dart';
import 'package:mood_map/common/emotion_rating.dart';

import 'package:mood_map/application/emotion_context.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/application/app_navigator.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database_manager.dart';

class RateEmotionsView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateEmotionsView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateEmotionsViewState(this._emotionContext);

}

class RateEmotionsViewState extends State<RateEmotionsView> {

  DatabaseReference _palletFirebase = DatabaseManager.emotionsReference();
  DatabaseReference _ratingFirebase = DatabaseManager.emotionsReference();

  EmotionContext _emotionContext;

  PageController _pageController;

  RateEmotionsViewState(_emotionContext) {
    this._emotionContext = _emotionContext;

    _palletFirebase.onChildAdded.listen(_retrievePalletEmotionsFromDatabase);
    _ratingFirebase.onChildAdded.listen(_retrieveRatingEmotionsFromDatabase);
  }

  List<RatableEmotionListItem> _ratingEmotions = new List();
  List<EmotionListItem> _palletEmotions = new List();

  final GlobalKey<FormState> _addEmotionFormKey = new GlobalKey<FormState>();
  String _emotionToAdd = "";

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(
        body: new PageView(

          controller: _pageController,
          physics: new NeverScrollableScrollPhysics(),

          children: <Widget>[

            _buildEmotionRatingScreen(),
            _buildEmotionPallet()

          ],

        ),

      )
    );

  }

  Widget _buildEmotionRatingScreen() {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("My emotions"),
      ),

      body: new ListView(
          children: _ratingEmotions
      ),

      persistentFooterButtons: <Widget>[

        new FlatButton(onPressed: () { _saveRatingsToDatabase(); },
          child: new Text("Rate"),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),),

        new FlatButton(onPressed: () { _saveRatingsToDatabase(); AppNavigator.navigateToMakeJournalView(); },
          child: new Text("Rate and Journal"),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),),

        new FlatButton(onPressed: () { _emotionContext.navigateBackToSpecifics(); },
          child: new Text("Back", style: new TextStyle(color: Colors.red),),
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),)

      ],

      floatingActionButton: FloatingActionButton.extended(
          onPressed: animateToPallet,
          icon: new Icon(Icons.add),
          label: new Text("Add From Emotion Pallet")),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }

  Widget _buildEmotionPallet() {

    return new Scaffold(

      appBar: new AppBar(title: new Text("Emotion Pallet"),),

      body: new ListView(
          children: _palletEmotions
      ),

      persistentFooterButtons: <Widget>[

        new FlatButton(
            onPressed: _addAllButton,
            child: new Text("Add all"),
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
        ),

        new FlatButton(
            onPressed: animateToRating,
            child: new Text("Back", style: new TextStyle(color: Colors.red),),
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
        )

      ],

      floatingActionButton: FloatingActionButton.extended(
          onPressed: _addEmotion,
          icon: new Icon(Icons.add),
          label: new Text("New Emotion")),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }


  void _animateToPage(int page) {

    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);

  }

  void animateToRating() {
    _animateToPage(0);
  }

  void animateToPallet() {
    _animateToPage(1);
  }


  void _addAllButton() {

    setState(() {
      _addEmotionsFromPalletToRatingScreen(_getSelectedEmotionsFromPallet());
    });

    animateToRating();

    Utilities.showSnackbarMessage(context, "Emotions added from Pallet");
  }

  void _addEmotionsFromPalletToRatingScreen(List<EmotionListItem> emotions) {

    setState(() {

      for(var emotion in emotions) {
        _addEmotionPalletItemToDatabase(emotion.getEmotion());
      }

      _ratingEmotions.addAll(emotions.map((EmotionListItem emotion) {
        return new RatableEmotionListItem(
            dbKey: emotion.getDBKey(),
            //The new emotions need to be placed in the proper context to be saved correctly
            category: _emotionContext.getCategory(),
            specific: _emotionContext.getSpecific(),
            emotion: emotion.getEmotion(),
        );
      }).toList());

    });
  }

  List<EmotionListItem> _getSelectedEmotionsFromPallet() {

    List<EmotionListItem> selected = new List();

    for(EmotionListItem item in _palletEmotions) {
      if(item.isSelected() && !_getEmotionNamesFromRatingEmotions().contains(item.getEmotion())) {
        selected.add(item);
      }
    }

    return selected;
  }

  List<String> _getEmotionNamesFromRatingEmotions() {

    List<String> emotions = new List();

    for(RatableEmotionListItem item in _ratingEmotions) {
      emotions.add(item.getEmotion());
    }

    return emotions;
  }

  List<String> getEmotionNamesFromPalletEmotions() {

    List<String> emotions = new List();

    for(EmotionListItem item in _palletEmotions) {
      emotions.add(item.getEmotion());
    }

    return emotions;
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
                              _addEmotionPalletItem(_emotionToAdd);
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

  void _addEmotionPalletItem(String emotionToAdd) {

    //Check to see if we dont already have it in the database which is mirrored with the data in the app
    for(var item in _palletEmotions) {
      if(item.getEmotion() == emotionToAdd){
        Navigator.pop(context, null);
        return;
      }
    }

    setState(() {

      _addEmotionPalletItemToDatabase(emotionToAdd);

      Navigator.pop(context, null);

      Utilities.showSnackbarMessage(context, "Emotion added to database");

    });

  }

  void _saveRatingsToDatabase() {

    setState(() {

      for(var ratingItem in _ratingEmotions) {

        var ref = DatabaseManager.emotionRatingPushReference();

        EmotionRating rating = new EmotionRating(
            ratingItem.getDBKey(),
            ratingItem.getCategory(),
            ratingItem.getSpecific(),
            ratingItem.getEmotion(),
            ratingItem.getRating());

        ref.set(rating.toJson());

      }

    });

    Utilities.showSnackbarMessage(context, "Emotions sucessfully rated");

    //We are done with the workflow so navigate back to the categories
    _emotionContext.navigateBackToCategories();

  }

  void _addEmotionPalletItemToDatabase(String emotionToAdd) {

    setState(() {

      var ref = DatabaseManager.emotionsPushReference();

      Emotion emotion = new Emotion(_emotionContext.getCategory(), _emotionContext.getSpecific(), emotionToAdd);

      ref.set(emotion.toJson());

    });

  }

  void _retrievePalletEmotionsFromDatabase(Event event) {

    setState(() {

      Emotion emotion = Emotion.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _palletEmotions) {
        if(listItem.getEmotion() == emotion.getEmotion()) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _addEmotionToPallet(emotion);
      }

    });

  }

  void _addEmotionToPallet(Emotion emotion) {
    final index = _palletEmotions.length;
    final newList = new List<EmotionListItem>.from(_palletEmotions)
      ..add(new EmotionListItem(
        dbKey: emotion.getDBKey(),
        category: emotion.getCategory(),
        specific: emotion.getSpecific(),
        emotion: emotion.getEmotion(),
        selected: true,
        onChange: (checked) => _palletListItemChange(index, checked),));

    setState(() {
      _palletEmotions = newList;
    });

  }

  void _retrieveRatingEmotionsFromDatabase(Event event) {

    setState(() {

      Emotion emotion = Emotion.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _ratingEmotions) {
        if(listItem.getEmotion() == emotion.getEmotion()) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere && emotion.getCategory() == _emotionContext.getCategory() && emotion.getSpecific() == _emotionContext.getSpecific()) {
        _addEmotionToRatingList(emotion);
      }

    });

  }

  void _addEmotionToRatingList(Emotion emotion) {

    final newList = new List<RatableEmotionListItem>.from(_ratingEmotions)
      ..add(new RatableEmotionListItem(
        dbKey: emotion.getDBKey(),
        category: emotion.getCategory(),
        specific: emotion.getSpecific(),
        emotion: emotion.getEmotion(),
      ));

    setState(() {
      _ratingEmotions = newList;
    });

  }

  void _palletListItemChange(int listIndex, bool checked) {

    final newList = new List<EmotionListItem>.from(_palletEmotions);
    EmotionListItem currentItem = _palletEmotions[listIndex];

    newList[listIndex] = new EmotionListItem(
      dbKey: currentItem.getDBKey(),
      category: currentItem.getCategory(),
      specific: currentItem.getSpecific(),
      emotion: currentItem.getEmotion(),
      selected: checked,
      onChange: currentItem.onChanged(),
    );

    setState(() {
      _palletEmotions = newList;
    });

  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}