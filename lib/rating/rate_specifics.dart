
import 'package:flutter/material.dart';

class RateSpecificsView extends StatefulWidget {

  Function _navigateToCategories;
  Function _navigateToEmotions;

  RateSpecificsView(this._navigateToCategories, this._navigateToEmotions);

  @override
  State<StatefulWidget> createState() => new RateSpecificsViewState(this._navigateToCategories, this._navigateToEmotions);

}

class RateSpecificsViewState extends State<RateSpecificsView> {

  Function _navigateToCategories;
  Function _navigateToEmotions;

  String _category;

  RateSpecificsViewState(this._navigateToCategories, this._navigateToEmotions);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(title: new Text(_category),),
        body: null,
        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  void setCategory(String category) {
    setState(() {
      this._category = category;
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