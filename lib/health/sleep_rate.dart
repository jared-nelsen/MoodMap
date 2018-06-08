
import 'package:flutter/material.dart';
import 'dart:async';

class SleepView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new SleepViewState();

}

class SleepViewState extends State<SleepView> {

  List<String> entries = new List();

  String toAdd = "";

  SleepViewState();

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

//        body: new ListView(
//            children: _emotions.map((String emotion) {
//              return emotion;
//            }).toList()
//        ),

        floatingActionButton: new FloatingActionButton(
          onPressed: _addCategory,
          child: new Icon(Icons.add),
        ),

      ),

    );

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
                onChanged: (String text) {toAdd = text;},
              ),),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new FlatButton(
                          child: new Text("Add", style: new TextStyle(color: Colors.green,),),
                          onPressed: () {
//                            if(toAdd.isNotEmpty) {
//                              setState(() {
//                                _emotions.add(new NavigableListItem(toAdd, _navigateToSpecifics));
//                                Navigator.pop(context, null);
//                              });}
                          }
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}
