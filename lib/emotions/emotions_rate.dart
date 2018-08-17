
import 'package:flutter/material.dart';

import 'package:mood_map/components/ratable_emotion_list_item.dart';
import 'package:mood_map/components/emotion_list_item.dart';

import 'package:mood_map/common/emotion.dart';
import 'package:mood_map/common/emotion_rating.dart';

import 'package:mood_map/components/emotion_context.dart';

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

class RateEmotionsView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateEmotionsView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateEmotionsViewState(this._emotionContext);

}

class RateEmotionsViewState extends State<RateEmotionsView> {

  DatabaseReference _firebase = FirebaseDatabase.instance.reference().child("emotions");

  EmotionContext _emotionContext;

  PageController _pageController;

  RateEmotionsViewState(_emotionContext) {
    this._emotionContext = _emotionContext;

    _firebase.onChildAdded.listen(_retrieveEmotionsFromDatabase);
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
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
            child: new RaisedButton(
                onPressed: animateToPallet,
                child: new Text("Add From Pallet")),)
        ],
      ),

      body: new ListView(
          children: _ratingEmotions
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: (){ _saveRatingsToDatabase(); }, child: new Text("Save")),
        new FlatButton(onPressed: null, child: new Text("Save and Journal")),
        new FlatButton(onPressed: (){ _emotionContext.navigateBackToSpecifics(); }, child: new Text("Back"))
      ],

    );
  }

  Widget _buildEmotionPallet() {
    return new Scaffold(

      appBar: new AppBar(title: new Text("Emotion Pallet"),
                          actions: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                              child: new RaisedButton(
                                  onPressed: _addEmotion,
                                  child: new Text("New Emotion")),)
                          ],),

      body: new ListView(
          children: _palletEmotions
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: addAllButton, child: new Text("Add all")),
        new FlatButton(onPressed: animateToRating, child: new Text("Back"))
      ],

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


  void addAllButton() {
    setState(() {
      addEmotionsToRating(getSelectedEmotionsFromPallet());
    });
    animateToRating();
  }

  void addEmotionsToRating(List<EmotionListItem> emotions) {
    setState(() {
      _ratingEmotions.addAll(emotions.map((EmotionListItem emotion) {
        return new RatableEmotionListItem(
            dbKey: emotion.getDBKey(),
            category: emotion.getCategory(),
            specific: emotion.getSpecific(),
            emotion: emotion.getEmotion(),
        );
      }).toList());
    });
  }

  List<EmotionListItem> getSelectedEmotionsFromPallet() {
    List<EmotionListItem> selected = new List();
    for(EmotionListItem item in _palletEmotions) {
      if(item.isSelected() && !ratingEmotionStrings().contains(item.getEmotion())) {
        selected.add(item);
      }
    }

    return selected;
  }

  List<String> ratingEmotionStrings() {
    List<String> emotions = new List();
    for(RatableEmotionListItem item in _ratingEmotions) {
      emotions.add(item.getEmotion());
    }
    return emotions;
  }

  List<String> palletEmotionStrings() {

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
                              _addEmotionPalletItemToDatabase(_emotionToAdd);
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

  void _saveRatingsToDatabase() {

    setState(() {

      var ref = FirebaseDatabase.instance.reference().child("emotion_ratings").push();

      for(var ratingItem in _ratingEmotions) {

//        EmotionRating rating = new EmotionRating(
//            ratingItem.getDBKey(),
//            ratingItem.getCategory(),
//            ratingItem.getSpecific(),
//            ratingItem.getEmotion(),
//            ratingItem.getRating());
//
//        ref.set(rating.toJson());

      }

    });

    //We are done with the workflow so navigate back to the categories
    _emotionContext.navigateBackToCategories();

  }

  void _addEmotionPalletItemToDatabase(String emotionToAdd) {

    //Check to see if we dont already have it in the database which is mirrored with the data in the app
    for(var item in _palletEmotions) {
      if(item.getEmotion() == emotionToAdd){
        Navigator.pop(context, null);
        return;
      }
    }

    setState(() {

      var ref = FirebaseDatabase.instance.reference().child("emotions").push();

      Emotion emotion = new Emotion(_emotionContext.getCategory(), _emotionContext.getSpecific(), emotionToAdd);

      ref.set(emotion.toJson());

      Navigator.pop(context, null);
    });

  }

  //We want all available emotions to go to the pallet but only emotions that align with the current emotion context
  //to go to the emotion rating screen
  void _retrieveEmotionsFromDatabase(Event event) {

    setState(() {

      Emotion emotion = Emotion.fromSnapshot(event.snapshot);

      //Add the emotion to the pallet

      bool alreadyThere = false;
      for(var listItem in _palletEmotions) {
        if(listItem.getDBKey() == emotion.getDBKey()) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _addEmotionToPallet(emotion);
      }

      //Add the emotion to the emotions screen based on context

      alreadyThere = false;
      for(var listItem in _ratingEmotions) {
        if(listItem.getDBKey() == emotion.getDBKey()) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere && emotion.getSpecific() == _emotionContext.getSpecific() && emotion.getCategory() == _emotionContext.getCategory()){
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