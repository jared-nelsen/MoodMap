

//The Sleep Chart takes the form of the Range Annotation Time Series Chart in the examples

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:mood_map/common/sleep_rating.dart';

class SleepTimeSeriesChart extends StatelessWidget {

  final List<charts.Series> seriesList;

  static DateTime minDate = new DateTime(10000);
  static DateTime maxDate = new DateTime(-10000);

  SleepTimeSeriesChart({this.seriesList});

  factory SleepTimeSeriesChart.blank(){
    return new SleepTimeSeriesChart();
  }

  factory SleepTimeSeriesChart.fromDataAcrossDimension(List<SleepRating> ratings, SleepDimension dimension) {
    return new SleepTimeSeriesChart(
      seriesList: _formData(ratings, dimension),
    );
  }

  @override
  Widget build(BuildContext context) {

    if(seriesList == null) {
      return new Container();
    }

    return new charts.TimeSeriesChart(seriesList, animate: true, behaviors: [

      new charts.RangeAnnotation([

        new charts.RangeAnnotationSegment(minDate, maxDate, charts.RangeAnnotationAxisType.domain),

      ]),

    ]);

  }

  static List<charts.Series<SleepDatum, DateTime>> _formData(List<SleepRating> ratings, SleepDimension dimension) {

    List<SleepDatum> measurements = new List<SleepDatum>();

    for(var rating in ratings) {

      if(rating.getDate().isBefore(minDate)){
        minDate = rating.getDate();
      }

      if(rating.getDate().isAfter(maxDate)) {
        maxDate = rating.getDate();
      }

      switch(dimension) {

        case SleepDimension.TIME_TO_BED:
          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(rating.getTimeToBed())));
          break;
        case SleepDimension.GOT_TO_SLEEP:
          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(rating.getGotToSleepTime())));
          break;
        case SleepDimension.TIME_LYING_AWAKE:

          int toBedMinutes = Utilities.calculateMinutesFromTimeString(rating.getTimeToBed());
          int toSleepMinutes = Utilities.calculateMinutesFromTimeString(rating.getGotToSleepTime());

          if(toSleepMinutes > 0 && toSleepMinutes < 720) {
            //We went to sleep in the morning so make the math work with magic
            toSleepMinutes = 1440 + toSleepMinutes;
          }

          int differential = toSleepMinutes - toBedMinutes;

          String lyingAwakeString = Utilities.formTimeStringFromMinutesInADay(differential);

          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(lyingAwakeString)));

          break;
        case SleepDimension.WAKE_UP_TIME:
          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(rating.getWokeUpTime())));
          break;
        case SleepDimension.SLEEP_PER_NIGHT:

          //We must calculate sleep per night with what we have

          int toSleepMinutes = Utilities.calculateMinutesFromTimeString(rating.getGotToSleepTime());
          int wakeUpSleepMinutes = Utilities.calculateMinutesFromTimeString(rating.getWokeUpTime());

          int asleepMinutes = wakeUpSleepMinutes + (1440 - toSleepMinutes);
          String asleepString = Utilities.formTimeStringFromMinutesInADay(asleepMinutes);

          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(asleepString)));

          break;
        case SleepDimension.QUALITY:
          measurements.add(new SleepDatum(rating.getDate(), Utilities.convertStringTimeToDouble(rating.getQuality())));
          break;
      }

    }

    return [
      new charts.Series<SleepDatum, DateTime>(
        id: 'Sleep Averages',
        domainFn: (SleepDatum datum, _) => datum.date,
        measureFn: (SleepDatum datum, _) => datum.measurement,
        data: measurements,
      )
    ];
  }
}


class SleepDatum {

  final DateTime date;
  final double measurement;

  SleepDatum(this.date, this.measurement);
}
