
import 'package:flutter/material.dart';

import 'package:mood_map/components/ratable_list_item.dart';
import 'package:mood_map/components/emotion_list_item.dart';

class RateEmotionsView extends StatefulWidget {

  Function _navigateToCategories;
  Function _navigateToSpecifics;

  RateEmotionsView(this._navigateToCategories, this._navigateToSpecifics);

  @override
  State<StatefulWidget> createState() => new RateEmotionsViewState(this._navigateToCategories, this._navigateToSpecifics);

}

class RateEmotionsViewState extends State<RateEmotionsView> {

  Function _navigateToCategories;
  Function _navigateToSpecifics;

  PageController _pageController;

  RateEmotionsViewState(this._navigateToCategories, this._navigateToSpecifics);

  List<RatableListItem> _ratingEmotions = new List();
  List<EmotionListItem> _palletEmotions = new List();

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
                child: new Text("Add From Pallete")),)
        ],
      ),

      body: new ListView(
          children: _ratingEmotions
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: null, child: new Text("Save")),
        new FlatButton(onPressed: null, child: new Text("Save and Journal")),
        new FlatButton(onPressed: _navigateToSpecifics, child: new Text("Back"))
      ],

    );
  }

  Widget _buildEmotionPallet() {
    return new Scaffold(

      appBar: new AppBar(title: new Text("Emotion Pallet"),),

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

  void addEmotionToRating() {
    setState(() {
      _ratingEmotions.add(new RatableListItem("Anger"));
    });
  }

  void _addEmotionToPallet(String emotion) {
    final index = _palletEmotions.length;
    final newList = new List<EmotionListItem>.from(_palletEmotions)
      ..add(new EmotionListItem(
        title: emotion,
        selected: true,
        onChange: (checked) => _palletListItemChange(index, checked),));

    setState(() {
      _palletEmotions = newList;
    });
  }

  void addEmotionsToRating(List<EmotionListItem> emotions) {
    setState(() {
      _ratingEmotions.addAll(emotions.map((EmotionListItem emotion) {
        return new RatableListItem(emotion.getTitle());
      }).toList());
    });
  }

  void _palletListItemChange(int listIndex, bool checked) {

    final newList = new List<EmotionListItem>.from(_palletEmotions);
    EmotionListItem currentItem = _palletEmotions[listIndex];

    newList[listIndex] = new EmotionListItem(
      title: currentItem.getTitle(),
      selected: checked,
      onChange: currentItem.onChanged(),
    );

    setState(() {
      _palletEmotions = newList;
    });

  }

  List<EmotionListItem> getSelectedEmotionsFromPallet() {
    List<EmotionListItem> selected = new List();
    for(EmotionListItem item in _palletEmotions) {
      if(item.isSelected() && !ratingEmotionStrings().contains(item.getTitle())) {
        selected.add(item);
      }
    }

    return selected;
  }

  List<String> ratingEmotionStrings() {
    List<String> emotions = new List();
    for(RatableListItem item in _ratingEmotions) {
      emotions.add(item.getTitle());
    }
    return emotions;
  }

  List<String> palletEmotionStrings() {
    List<String> emotions = new List();
    for(EmotionListItem item in _palletEmotions) {
      emotions.add(item.getTitle());
    }
    return emotions;
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
    _addEmotionToPallet("First");
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}