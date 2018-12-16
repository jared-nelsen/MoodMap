
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/exercise_rating.dart';

class ExerciseView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ExerciseViewState();

}

class ExerciseViewState extends State<ExerciseView> {

  String _rating = '1';
  var _ratings = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  String _type = 'Running';
  var _types = ['Walking', 'Running', 'Hiking', 'Weightlifting', 'Yoga', 'Cycling', 'Swimming', 'Fitness Class', 'Sports'];

  String _duration = '30';

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        body: new SingleChildScrollView (

          child: new Column(

            children: <Widget>[

              _title(),
              _divider(),
              _rateExercise(),
              _whiteSpace(),
              _whatType(),
              _whiteSpace(),
              _howLong()

            ],

          ),
        ),

        persistentFooterButtons: <Widget>[
          new FlatButton(
            onPressed: _saveEntry,
            child: new Text("Rate it"),
            color: Colors.green,
            textColor: Colors.white,)
        ],

        resizeToAvoidBottomPadding: false,
        ),

      );

  }

  Widget _title() {

    return new Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[

        new Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: new Text("What did your exercise look like today?", style: new TextStyle(fontSize: 18.0),)
        )

      ],

    );
  }

  Widget _rateExercise() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("One to ten, how did your exercise go?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Column (
          children: <Widget>[

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new DropdownButton<String>(

                  items: _ratings.map((String rating) {
                    return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

                  value: _rating,

                  onChanged: (String value) {
                    setState(() {
                      _rating = value;
                    });
                  },

                )
            ),

          ],
        )

      ],
    );

  }

  Widget _whatType() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("What type of exercise was it?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Column (
          children: <Widget>[

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new DropdownButton<String>(

                  items: _types.map((String rating) {
                    return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

                  value: _type,

                  onChanged: (String value) {
                    setState(() {
                      _type = value;
                    });
                  },

                )
            ),

          ],
        )

      ],
    );

  }

  Widget _howLong() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("How many minutes did you exercise?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: new SizedBox (
              width: 30.0,
              child: new TextField(

                decoration: new InputDecoration(
                  hintText: "30"
                ),

                inputFormatters: [ new WhitelistingTextInputFormatter(new RegExp("^[0-9]*\$"))],

                onChanged: (value) { setState(() { _duration = value; }); },
              ),

            ),
        ),

        new Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
          child: new Text("minutes", style: new TextStyle(fontSize: 16.0),),
        )

      ],
    );

  }

  Future<Null> _saveEntry() async {

    if(_duration.isEmpty) {
      Utilities.showSnackbarMessage(context, "How long did you exercise?");
      return;
    }

    if(await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
        return SimpleDialog(
          title: new Text("Rate your exercise?"),
          children: <Widget>[

            new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    SimpleDialogOption(
                      onPressed: (){ Navigator.pop(context, true); },
                      child: new Text("Rate it", style: new TextStyle(color: Colors.green,),),
                    ),

                    SimpleDialogOption(
                      onPressed: (){ Navigator.pop(context, false); },
                      child: new Text("Nevermind"),
                    )

                  ],
                )
              ],
            )

          ],
        );
      }
    ))
    {

      var ref = Database.exerciseEntriesPushReference();

      ExerciseRating rating = new ExerciseRating(_rating, _type, _duration);

      ref.set(rating.toJson());

      Utilities.showSnackbarMessage(context, "Exercise rating successful");

    }

  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 18.0,
      indent: 0.0,
    );
  }

  Widget _whiteSpace() {
    return new Divider(
      color: Colors.white,
      height: 15.0,
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