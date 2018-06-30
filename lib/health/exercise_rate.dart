
import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:mood_map/common/exercise_rating.dart';

class ExerciseView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ExerciseViewState();

}

class ExerciseViewState extends State<ExerciseView> {

  String _exercised = 'Yes';
  var _exercising = ['Yes', 'No'];

  String _type = 'Cardio';
  var _types = ['Cardio', 'Weightlifting'];

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
          new FlatButton(onPressed: _saveEntry, child: new Text("Rate it"))
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

  void _saveEntry() {
    var ref = FirebaseDatabase.instance.reference().child("exercise_entries").push();

    ExerciseSettings rating = new ExerciseSettings(_exercised, _type, _duration);

    ref.set(rating.toJson());
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