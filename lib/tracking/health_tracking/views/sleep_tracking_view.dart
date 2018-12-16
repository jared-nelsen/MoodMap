
import 'package:flutter/material.dart';

import 'package:after_layout/after_layo'
    'ut.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/tracking/health_tracking/components/sleep_time_series_chart.dart';
import 'package:mood_map/common/sleep_rating.dart';

class SleepTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SleepTrackingViewState();

}

class _SleepTrackingViewState extends State<SleepTrackingView> with SingleTickerProviderStateMixin, AfterLayoutMixin<SleepTrackingView> {

  String _chartCaption = "";

  SleepTimeSeriesChart _sleepChart = SleepTimeSeriesChart.blank();

  String _averageTimeToBed = "";
  String _averageTimeToSleep = "";
  String _averageTimeLyingAwake = "";
  String _averageWakeUpTime = "";
  String _averageSleepPerNight = "";
  String _averageSleepQuality = "";

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _titleBar(),
            _divider(),
            _chart(context),
            _indicatorBar(),
            _statisticsCard()
          ],
        ),
      ),

    );

  }

  @override
  void afterFirstLayout(BuildContext context) {
    _loadData(SleepDimension.TIME_TO_BED);
    Utilities.showLongSnackbarMessage(context, "You can tap on a statistics tile to see it's data in the graph.");
  }
  
  SizedBox _chart(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new SizedBox(
      width: width,
      height: 200.0,
      child: _sleepChart,
    );
  }

  Column _statisticsCard() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _timeToBed(),
        _timeToSleep(),
        _timeLyingAwake(),
        _wakeUpTime(),
        _sleepPerNight(),
        _sleepQuality()
      ],
    );
  }

  Widget _titleBar() {

    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
          child: new Text("Here are some useful stats about your sleep", style: new TextStyle(fontSize: 18.0),),
        )
      ],
    );
  }

  Widget _indicatorBar() {

    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
          child: new Text("Showing $_chartCaption", style: new TextStyle(fontSize: 18.0),),
        )
      ],
    );
  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 8.0,
      indent: 0.0,
    );
  }

  Card _timeToBed() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time to Bed", style: _style(),),
            subtitle: new Text("$_averageTimeToBed", style: _style(),),
            onTap: (){ _loadData(SleepDimension.TIME_TO_BED); },
          )
        ],
      ),
    );
  }

  Card _timeToSleep() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time to sleep", style: _style(),),
            subtitle: new Text("$_averageTimeToSleep", style: _style(),),
            onTap: (){ _loadData(SleepDimension.GOT_TO_SLEEP); },
          )
        ],
      ),
    );
  }

  Card _timeLyingAwake() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time Lying Awake", style: _style(),),
            subtitle: new Text("$_averageTimeLyingAwake", style: _style(),),
            onTap: (){ _loadData(SleepDimension.TIME_LYING_AWAKE); },
          )
        ],
      ),
    );
  }

  Card _wakeUpTime() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Wake Up Time", style: _style(),),
            subtitle: new Text("$_averageWakeUpTime", style: _style(),),
            onTap: () { _loadData(SleepDimension.WAKE_UP_TIME); },
          )
        ],
      ),
    );
  }

  Card _sleepPerNight() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Sleep Per Night", style: _style(),),
            subtitle: new Text("$_averageSleepPerNight", style: _style(),),
            onTap: (){ _loadData(SleepDimension.SLEEP_PER_NIGHT); },
          )
        ],
      ),
    );
  }

  Card _sleepQuality() {
    return new Card(
      elevation: 5.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Sleep Quality", style: _style(),),
            subtitle: new Text("$_averageSleepQuality", style: _style(),),
            onTap: () { _loadData(SleepDimension.QUALITY); },
          )
        ],
      ),
    );
  }

  TextStyle _style() {
    return new TextStyle(fontSize: 18.0);
  }

  void _loadData(SleepDimension dimension) {

    setState(() {
      switch(dimension){
        case SleepDimension.TIME_TO_BED:
            _chartCaption = "what time you go to bed";
          break;
        case SleepDimension.GOT_TO_SLEEP:
            _chartCaption = "when you actually fall asleep";
          break;
        case SleepDimension.TIME_LYING_AWAKE:
            _chartCaption = "how long you spend lying awake";
          break;
        case SleepDimension.WAKE_UP_TIME:
            _chartCaption = "what time you wake up";
          break;
        case SleepDimension.SLEEP_PER_NIGHT:
            _chartCaption = "how much sleep you get per night";
          break;
        case SleepDimension.QUALITY:
            _chartCaption = "how you've rated your sleep";
          break;
      }
    });

    var ref = Database.sleepEntriesReference();

    ref.once().then((DataSnapshot snapshot) {

      List<SleepRating> ratings = SleepRating.setOfFromSnapshot(snapshot);

      if(ratings.length == 0) {

        Utilities.showSnackbarMessage(context, "You've not rated your sleep enough to see any statistics!");

        setState(() {
          _averageTimeToBed = "Unknown";
          _averageTimeToSleep = "Unknown";
          _averageTimeLyingAwake = "Unknown";
          _averageWakeUpTime = "Unknown";
          _averageSleepPerNight = "Unknown";
          _averageSleepQuality = "Unknown";
        });

        return;
      }

      //Calculate statistics
      int sumOfTimesToBed =   calculateAverageTimeToBed(ratings);
      int sumOfTimesToSleep = calculateAverageTimeToSleep(ratings);
                              calculateAverageTimeLyingAwake(ratings, sumOfTimesToSleep, sumOfTimesToBed);
      int sumOfWakeUpTimes =  calculateAverageWakeUpTimes(ratings);
                              calculateAverageTimeAsleep(ratings, sumOfWakeUpTimes, sumOfTimesToSleep);
                              calculateAverageSleepQuality(ratings);

      //Load the chart with the averageTimeToBed
      setState(() {
        _sleepChart = SleepTimeSeriesChart.fromDataAcrossDimension(ratings, dimension);
      });

    });

  }

  int calculateAverageTimeToBed(List<SleepRating> ratings) {

    int sumOfTimesToBed = 0;
    for(var rating in ratings) {
      sumOfTimesToBed += Utilities.calculateMinutesFromTimeString(rating.getTimeToBed());
    }
    int averageTimesToBed = (sumOfTimesToBed / ratings.length).toInt();

    setState(() {
      _averageTimeToBed = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimesToBed));
    });

    return sumOfTimesToBed;
  }

  int calculateAverageTimeToSleep(List<SleepRating> ratings) {

    int sumOfTimesToSleep = 0;
    for(var rating in ratings) {
      sumOfTimesToSleep += Utilities.calculateMinutesFromTimeString(rating.getGotToSleepTime());
    }
    int averageTimesToSleep = (sumOfTimesToSleep / ratings.length).toInt();

    setState(() {
      _averageTimeToSleep = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimesToSleep));
    });

    return sumOfTimesToSleep;
  }

  void calculateAverageTimeLyingAwake(List<SleepRating> ratings, int sumOfTimesToSleep, int sumOfTimesToBed) {

    int differenceToBedAndToSleep = sumOfTimesToSleep - sumOfTimesToBed;
    differenceToBedAndToSleep = differenceToBedAndToSleep.abs();
    int averageTimeLyingAwake = (differenceToBedAndToSleep / ratings.length).toInt();

    setState(() {
      _averageTimeLyingAwake = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimeLyingAwake));
    });

  }

  int calculateAverageWakeUpTimes(List<SleepRating> ratings) {

    int sumOfWakeUpTimes = 0;
    for(var rating in ratings) {
      sumOfWakeUpTimes += Utilities.calculateMinutesFromTimeString(rating.getWokeUpTime());
    }
    int averageWakeUpTime = (sumOfWakeUpTimes / ratings.length).toInt();

    setState(() {
      _averageWakeUpTime = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageWakeUpTime));
    });

    return sumOfWakeUpTimes;
  }

  void calculateAverageTimeAsleep(List<SleepRating> ratings, int sumOfWakeUpTimes, int sumOfTimesToSleep) {

    int differenceWakeUpToGoToSleep = sumOfWakeUpTimes - sumOfTimesToSleep;
    differenceWakeUpToGoToSleep = differenceWakeUpToGoToSleep.abs();
    int averageSleepPerNight = (differenceWakeUpToGoToSleep / ratings.length).toInt();

    setState(() {
      _averageSleepPerNight = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(averageSleepPerNight));
    });

  }

  void calculateAverageSleepQuality(List<SleepRating> ratings) {

    int totalQuality = 0;
    for(var rating in ratings) {
      totalQuality += int.tryParse(rating.getQuality());
    }
    int quality = (totalQuality / ratings.length).toInt();

    setState(() {
      _averageSleepQuality = quality.toString();
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