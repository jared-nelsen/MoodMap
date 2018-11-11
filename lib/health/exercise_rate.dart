
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/utilities/database_manager.dart';

import 'package:mood_map/common/exercise_rating.dart';

class ExerciseView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ExerciseViewState();

}

class ExerciseViewState extends State<ExerciseView> {

  String _exercised = 'Yes';
  var _exercising = ['Yes', 'No'];

  String _type = 'Cardio';
  var _types = ['Cardio', 'Weightlifting', 'Yoga'];

  String _duration = '30 minutes';
  var _durations = ['10 minutes','20 minutes','30 minutes','45 minutes','An hour','More than an hour',];

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Scaffold(

        body: new Container (

          child: new Column(

            children: <Widget>[

              _title(),
              _divider(),
              _didExercise(),
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
        ),

      );

  }

  Widget _title() {

    return new Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: <Widget>[

        new Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: new Text("What did your excercise look like today?", style: new TextStyle(fontSize: 18.0),)
        )

      ],

    );
  }

  Widget _didExercise() {

    return new Row(

      children: <Widget>[

        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
            child: new Text("Did you exercise today?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Column (
          children: <Widget>[

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new DropdownButton<String>(

                  items: _exercising.map((String rating) {
                    return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

                  value: _exercised,

                  onChanged: (String value) {
                    setState(() {
                      _exercised = value;
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
            child: new Text("How long did you exercise?", style: new TextStyle(fontSize: 18.0),),),
        ),

        new Column (
          children: <Widget>[

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new DropdownButton<String>(

                  items: _durations.map((String rating) {
                    return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

                  value: _duration,

                  onChanged: (String value) {
                    setState(() {
                      _duration = value;
                    });
                  },

                )
            ),

          ],
        )

      ],
    );

  }

  Future<Null> _saveEntry() async {

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

      var ref = DatabaseManager.exercisePushReference();

      ExerciseSettings rating = new ExerciseSettings(_exercised, _type, _duration);

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

  void _confirm(String confirmation) {
    Utilities.showSnackbarMessage(context, confirmation);
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