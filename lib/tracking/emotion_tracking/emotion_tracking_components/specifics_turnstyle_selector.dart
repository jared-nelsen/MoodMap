
import 'package:flutter/material.dart';

import 'package:mood_map/application/emotion_context.dart';
import 'package:mood_map/tracking/tracking_components/turnstyle_item.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/specific.dart';

class SpecificsTurnstyleSelector extends StatefulWidget {
  _SpecificsTurnstyleSelectorState _state;

  EmotionContext _emotionContext;

  Function _outerSelectedCallbackFunction;

  SpecificsTurnstyleSelector(this._emotionContext, this._outerSelectedCallbackFunction);

  @override
  State<StatefulWidget> createState() => _createState();

  _SpecificsTurnstyleSelectorState _createState() {
    _state = new _SpecificsTurnstyleSelectorState(this._emotionContext, this._outerSelectedCallbackFunction);
    return _state;
  }

  void reloadSpecifics() {
    _state.reloadSpecifics();
  }

}

class _SpecificsTurnstyleSelectorState extends State<SpecificsTurnstyleSelector> {

  DatabaseReference _specificsReference = Database.specificsReference();

  EmotionContext _emotionContext;

  Function _outerSelectedCallbackFunction;

  List<TurnstyleItem> _items = new List<TurnstyleItem>();

  _SpecificsTurnstyleSelectorState(this._emotionContext, this._outerSelectedCallbackFunction){
    _specificsReference.onChildAdded.listen(_retrieveSpecificsFromDatabase);
  }

  @override
  Widget build(BuildContext context) {

    return new Container(

      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),

      height: 30.0,

      child: ListView(
          scrollDirection: Axis.horizontal,

          children: _items.map((TurnstyleItem item){
            return item;
          }).toList()

      ),

    );

  }

  void _retrieveSpecificsFromDatabase(Event event) {

    setState(() {

      SpecificsItem item = SpecificsItem.fromSnapshot(event.snapshot);

      String specificsName = item.getSpecific();

      bool alreadyThere = false;
      for(TurnstyleItem listItem in _items) {

        if(listItem.getText() == specificsName) {
          alreadyThere = true;
          break;
        }

      }

      if(!alreadyThere && item.getCategory() == _emotionContext.getCategory()) {
        _items.add(new TurnstyleItem(specificsName, _itemSelected));
      }

    });

  }

  void reloadSpecifics() {

    setState(() {
      _items.clear();
      _specificsReference.onChildAdded.listen(_retrieveSpecificsFromDatabase);
    });

  }

  void _itemSelected(String selectedText) {

    for(TurnstyleItem item in _items) {
      //item.setSelected(false);
    }
    //This call calls set state after disposal. Figure out a way around this.

    List<dynamic> args = new List<dynamic>();
    args.add(selectedText);

    Function.apply(_outerSelectedCallbackFunction, args);

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

