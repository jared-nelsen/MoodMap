
import 'package:flutter/material.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/exercise_rating.dart';

import 'package:mood_map/tracking/health_tracking/components/exercise_date_chart.dart';

class ExerciseTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ExerciseTrackingViewState();

}

class _ExerciseTrackingViewState extends State<ExerciseTrackingView> with SingleTickerProviderStateMixin {

  ExerciseDateChart _durationAcrossTimeChart = ExerciseDateChart.blank();

  _ExerciseTrackingViewState(){
    _loadData();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _durationAcrossTimeGraph(context)
          ],
        )
      )
          
    );

  }

  SizedBox _durationAcrossTimeGraph(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new SizedBox(
      width: width,
      height: 200.0,
      child: _durationAcrossTimeChart,
    );
  }


  void _loadData() {

    var ref = Database.exerciseEntriesReference();

    ref.once().then((DataSnapshot snapshot) {

      List<ExerciseRating> ratings = ExerciseRating.setOfFromSnapshot(snapshot);

      if(ratings == 0) {
        //do something
      }

      setState(() {
        _durationAcrossTimeChart = ExerciseDateChart.fromDataAcrossTime(ratings);
      });

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