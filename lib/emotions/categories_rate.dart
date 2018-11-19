
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/common/category.dart';
import 'package:mood_map/components/navigable_category_item.dart';
import 'package:mood_map/application/emotion_context.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';
import 'package:mood_map/utilities/utilities.dart';
import 'package:after_layout/after_layout.dart';

import 'package:mood_map/emotions/emotion_deletion.dart';

class RateCategoriesView extends StatefulWidget {

  EmotionContext _emotionContext;

  RateCategoriesView(this._emotionContext);

  @override
  State<StatefulWidget> createState() => new RateCategoriesViewState(_emotionContext);

}

class RateCategoriesViewState extends State<RateCategoriesView> with AfterLayoutMixin<RateCategoriesView> {

  DatabaseReference _categoriesFirebase = Database.categoriesReference();

  EmotionContext _emotionContext;

  List<NavigableCategoryItem> _categories = new List();

  String _categoryToAdd;

  RateCategoriesViewState(EmotionContext context){
    this._emotionContext = context;

    _categoriesFirebase.onChildAdded.listen(_retrieveFromDatabase);
  }

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        appBar: new AppBar(title: new Text("Emotion Category"),
                           actions: <Widget>[
                             new Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                              child: new RaisedButton(
                                  onPressed: () { _emotionContext.navigateToQuickRate(); },
                                  child: new Text("Quick Rate Emotions")),)
                          ],),

        body: new ListView(
          children: _categories.map((NavigableCategoryItem emotion) {
            return emotion;
          }).toList()
        ),

        floatingActionButton: new Padding(
          padding: EdgeInsets.all(10.0),
          child: FloatingActionButton.extended(onPressed: _addCategory,
                                               icon: new Icon(Icons.add),
                                               label: new Text("Add a Category")),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      ),

    );

  }

  @override
  void afterFirstLayout(BuildContext context) {
    Utilities.showPageInfoSnackbarMessage(context, "You can long press a category to remove it");
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
                onChanged: (String text) {_categoryToAdd = text;},
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

      var ref = Database.categoriesPushReference();

      CategoryItem item = new CategoryItem(_categoryToAdd);

      ref.set(item.toJson());

      Navigator.pop(context, null);

      Utilities.showSnackbarMessage(context, "Category added successfully");

    });

  }

  void _retrieveFromDatabase(Event event) {

    setState(() {

      CategoryItem item = CategoryItem.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var listItem in _categories) {
        if(listItem.dbKey == item.key) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere) {
        _categories.add(new NavigableCategoryItem(item.key, item.getCategory(), _emotionContext, _deleteCategory));
      }

    });

  }

  void _deleteCategory(String category) async {

    await showDialog(context: context,
        builder: (BuildContext context) {

          return new SimpleDialog(
            title: new Text("Are you sure you would like to delete the $category category?\n\n"
                "All Specifics, Specific Emotions, and Emotion rating data associated with this"
                " category will also be deleted."),
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
                            for(int i = 0; i < _categories.length; i++) {
                              NavigableCategoryItem item = _categories.elementAt(i);
                              if(category == item.getCategory()) {
                                index = i;
                                break;
                              }
                            }

                            //Remove from the database
                            EmotionDeletionModule.deleteCategory(category);

                            //Remove from the list
                            _categories.removeAt(index);

                            _confirm("The $category category and all associated data has been removed");

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
