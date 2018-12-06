
import 'package:flutter/material.dart';

import 'package:after_layout/after_layout.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/sleep_rating.dart';

class SleepTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SleepTrackingViewState();

}

class _SleepTrackingViewState extends State<SleepTrackingView> with SingleTickerProviderStateMixin, AfterLayoutMixin<SleepTrackingView> {


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
        child: _statisticsCard(),
      ),

        persistentFooterButtons: <Widget>[
          new FlatButton(onPressed: () {_loadData();}, child: new Text("Toot"))
        ],
      );

  }

  @override
  void afterFirstLayout(BuildContext context) {
    _loadData();
  }

  Row _chartAndStatistics() {
    //Combine Chard and statistics somehow to fit in SingleChildscroll view
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

  Card _timeToBed() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time to Bed", style: _style(),),
            subtitle: new Text("$_averageTimeToBed", style: _style(),),
          )
        ],
      ),
    );
  }

  Card _timeToSleep() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time to sleep", style: _style(),),
            subtitle: new Text("$_averageTimeToSleep", style: _style(),),
          )
        ],
      ),
    );
  }

  Card _timeLyingAwake() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Time Lying Awake", style: _style(),),
            subtitle: new Text("$_averageTimeLyingAwake", style: _style(),),
          )
        ],
      ),
    );
  }

  Card _wakeUpTime() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Wake Up Time", style: _style(),),
            subtitle: new Text("$_averageWakeUpTime", style: _style(),),
          )
        ],
      ),
    );
  }

  Card _sleepPerNight() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Sleep Per Night", style: _style(),),
            subtitle: new Text("$_averageSleepPerNight", style: _style(),),
          )
        ],
      ),
    );
  }

  Card _sleepQuality() {
    return new Card(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text("Average Sleep Quality", style: _style(),),
            subtitle: new Text("$_averageSleepQuality", style: _style(),),
          )
        ],
      ),
    );
  }

  TextStyle _style() {
    return new TextStyle(fontSize: 18.0);
  }

  void _loadData() {

    var ref = Database.sleepEntriesReference();

    ref.once().then((DataSnapshot snapshot) {

      List<SleepRating> ratings = SleepRating.setOfFromSnapshot(snapshot);

      //Here I can filter on date range selected


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

      setState(() {

        //Calculate average time to bed
        int sumOfTimesToBed = 0;
        for(var rating in ratings) {
          sumOfTimesToBed += Utilities.calculateMinutesFromTimeString(rating.getTimeToBed());
        }
        int averageTimesToBed = (sumOfTimesToBed / ratings.length).toInt();
        _averageTimeToBed = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimesToBed));

        //Calculate average time to sleep
        int sumOfTimesToSleep = 0;
        for(var rating in ratings) {
          sumOfTimesToSleep += Utilities.calculateMinutesFromTimeString(rating.getGotToSleepTime());
        }
        int averageTimesToSleep = (sumOfTimesToSleep / ratings.length).toInt();
        _averageTimeToSleep = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimesToSleep));

        //Calculate average time lying awake
        int differenceToBedAndToSleep = sumOfTimesToSleep - sumOfTimesToBed;
        differenceToBedAndToSleep = differenceToBedAndToSleep.abs();
        int averageTimeLyingAwake = (differenceToBedAndToSleep / ratings.length).toInt();
        _averageTimeLyingAwake = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(averageTimeLyingAwake));

        //Calculate average wake up time
        int sumOfWakeUpTimes = 0;
        for(var rating in ratings) {
          sumOfWakeUpTimes += Utilities.calculateMinutesFromTimeString(rating.getWokeUpTime());
        }
        int averageWakeUpTime = (sumOfWakeUpTimes / ratings.length).toInt();
        _averageWakeUpTime = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(averageWakeUpTime));

        //Calculate average time asleep every night
        int differenceWakeUpToGoToSleep = sumOfWakeUpTimes - sumOfTimesToSleep;
        differenceWakeUpToGoToSleep = differenceWakeUpToGoToSleep.abs();
        int averageSleepPerNight = (differenceWakeUpToGoToSleep / ratings.length).toInt();
        _averageSleepPerNight = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(averageSleepPerNight));

        //Calculate average quality from ratings
        int totalQuality = 0;
        for(var rating in ratings) {
          totalQuality += int.tryParse(rating.getQuality());
        }
        int quality = (totalQuality / ratings.length).toInt();
        _averageSleepQuality = quality.toString();

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