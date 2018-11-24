
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/tracking_components/turnstyle_item.dart';

import 'package:mood_map/application/emotion_context.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/category.dart';

class CategoryTurnstyleSelector extends StatefulWidget {

  EmotionContext _emotionContext;

  Function _outerSelectedCallbackFunction;

  CategoryTurnstyleSelector(this._emotionContext, this._outerSelectedCallbackFunction);

  @override
  State<StatefulWidget> createState() => new _CategoryTurnstyleSelectorState(this._emotionContext, this._outerSelectedCallbackFunction);

}

class _CategoryTurnstyleSelectorState extends State<CategoryTurnstyleSelector> {

  DatabaseReference _categoriesReference = Database.categoriesReference();

  EmotionContext _emotionContext;

  Function _outerSelectedCallbackFunction;

  List<TurnstyleItem> _items = new List<TurnstyleItem>();

  _CategoryTurnstyleSelectorState(this._emotionContext, this._outerSelectedCallbackFunction){
    _categoriesReference.onChildAdded.listen(_retrieveCategoryFromDatabase);
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

  void _retrieveCategoryFromDatabase(Event event) {

    setState(() {

      CategoryItem item = CategoryItem.fromSnapshot(event.snapshot);

      String categoryName = item.getCategory();

      bool alreadyThere = false;
      for(TurnstyleItem listItem in _items) {
        if(listItem.getText() == categoryName) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _items.add(new TurnstyleItem(categoryName, _itemSelected));
      }

    });

    //Whenever we are loading categories just set the first as the selected to enable
    //the specifics to load
    _emotionContext.setCategory(_items.elementAt(0).getText());

  }

  void _itemSelected(String selectedText) {

    _emotionContext.setCategory(selectedText);

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

