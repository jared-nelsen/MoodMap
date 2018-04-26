
import 'package:flutter/material.dart';

class RateCategoriesView extends StatefulWidget {

  Function _navigateToSpecifics;

  RateCategoriesView(this._navigateToSpecifics);

  @override
  State<StatefulWidget> createState() => new RateCategoriesViewState(_navigateToSpecifics);

}

class RateCategoriesViewState extends State<RateCategoriesView> {

  Function _navigateToSpecifics;

  RateCategoriesViewState(this._navigateToSpecifics);

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        appBar: new AppBar(title: new Text("Rate My Emotions With..."),),

        body: null,

        floatingActionButton: new FloatingActionButton(
          onPressed: null,
          child: new Icon(Icons.add),
        ),

      ),

    );

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
