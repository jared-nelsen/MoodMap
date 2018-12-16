
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:mood_map/common/exercise_rating.dart';

class ExerciseDateChart extends StatelessWidget {

  final List<charts.Series> seriesList;

  ExerciseDateChart({this.seriesList});

  factory ExerciseDateChart.blank(){
    return new ExerciseDateChart();
  }

  factory ExerciseDateChart.fromDataAcrossTime(List<ExerciseRating> ratings) {
    return new ExerciseDateChart(
      seriesList: _formData(ratings)
    );
  }

  @override
  Widget build(BuildContext context) {

    if(seriesList == null) {
      return new Container();
    }

    return new charts.ScatterPlotChart(seriesList);
  }

  static List<charts.Series<_ExerciseDatum, DateTime>> _formData(List<ExerciseRating> ratings) {

    //120 minutes will be the upper bound on exercise volume such that we may scale the instance
    //marker's radius by: 4.4

    List<_ExerciseDatum> measurements = new List<_ExerciseDatum>();

    for(var rating in ratings) {

      int duration = int.parse(rating.getDuration());

      measurements.add(new _ExerciseDatum(rating.getDate(), duration, (4.4 * duration)));
    }

    return [
      new charts.Series<_ExerciseDatum, DateTime>(
        id: 'Exercise Duration Over Time',
        colorFn: (_ExerciseDatum sales, _) {
            return charts.MaterialPalette.green.shadeDefault;
        },
        domainFn: (_ExerciseDatum sales, _) => sales.day,
        measureFn: (_ExerciseDatum sales, _) => sales.duration,
        radiusPxFn: (_ExerciseDatum sales, _) => sales.radius,
        data: measurements,
      )
    ];
  }
}

class _ExerciseDatum {

  final DateTime day;
  final int duration;
  final double radius;

  _ExerciseDatum(this.day, this.duration, this.radius);
}