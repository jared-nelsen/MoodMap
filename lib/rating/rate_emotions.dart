
import 'package:flutter/material.dart';

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

  String _specifics;

  RateEmotionsViewState(this._navigateToCategories, this._navigateToSpecifics);

  @override
  Widget build(BuildContext context) {

    return new Container(
      child: new Scaffold(
        appBar: new AppBar(title: new Text(_specifics),),
        body: null,
        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
        ),
      ),
    );

  }

  void setSpecifics(String specifics) {
    setState(() {
      _specifics = specifics;
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