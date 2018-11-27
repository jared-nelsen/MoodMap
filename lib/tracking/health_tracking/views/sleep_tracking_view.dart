
import 'package:flutter/material.dart';

import 'package:mood_map/utilities/utilities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/sleep_rating.dart';

class SleepTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SleepTrackingViewState();

}

class _SleepTrackingViewState extends State<SleepTrackingView> with SingleTickerProviderStateMixin {

  List<SwitchListTile> _dataCards = new List<SwitchListTile>();

  bool _averageTimeToBedSelected = false;
  String _averageTimeToBed = "";
  bool _averageTimeToSleepSelected = false;
  String _averageTimeToSleep = "";
  bool _averageTimeLyingAwakeSelected = false;
  String _averageTimeLyingAwake = "";
  bool _averageWakeUpTimeSelected = false;
  String _averageWakeUpTime = "";
  bool _averageSleepPerNightSelected = false;
  String _averageSleepPerNight = "";
  bool _averageQualitySelected = false;
  String _averageSleepQuality = "";

  _SleepTrackingViewState() {
    _dataCards.add(_timeToBed());
    _dataCards.add(_timeToSleep());
    _dataCards.add(_timeLyingAwake());
    _dataCards.add(_wakeUpTime());
    _dataCards.add(_sleepPerNight());
    _dataCards.add(_sleepQuality());

    _loadData();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new ListView(
        children: _dataCards,
      )

      );

  }

//  Widget _statisticsCard() {
//
//    return new Padding(
//
//      padding: EdgeInsets.all(5.0),
//
//      child: new Scaffold(
//        body: new ListView(
//          children: _dataCards,
//        ),
//      )
//
//    );
//
//  }

  SwitchListTile _timeToBed() {
    return new SwitchListTile(
        title: new Text("Average time to bed: $_averageTimeToBed", style: _style(),),
        value: _averageTimeToBedSelected,
        onChanged: (bool value) { setState(() { _averageTimeToBedSelected = value;});}
    );
  }

  SwitchListTile _timeToSleep() {
    return new SwitchListTile(
        title: new Text("Average time to sleep: $_averageTimeToSleep", style: _style(),),
        value: _averageTimeToSleepSelected,
        onChanged: (bool value) { setState(() { _averageTimeToSleepSelected = value;});}
    );
  }

  SwitchListTile _timeLyingAwake() {
    return new SwitchListTile(
        title: new Text("Average time lying awake: $_averageTimeLyingAwake", style: _style(),),
        value: _averageTimeLyingAwakeSelected,
        onChanged: (bool value) { setState(() { _averageTimeLyingAwakeSelected = value;});}
    );
  }

  SwitchListTile _wakeUpTime() {
    return new SwitchListTile(
        title: new Text("Average wake up time: $_averageWakeUpTime", style: _style(),),
        value: _averageWakeUpTimeSelected,
        onChanged: (bool value) { setState(() { _averageWakeUpTimeSelected = value;});}
    );
  }

  SwitchListTile _sleepPerNight() {
    return new SwitchListTile(
        title: new Text("Average sleep per night: $_averageSleepPerNight", style: _style(),),
        value: _averageSleepPerNightSelected,
        onChanged: (bool value) { setState(() { _averageSleepPerNightSelected = value;});}
    );
  }

  SwitchListTile _sleepQuality() {
    return new SwitchListTile(
        title: new Text("Average sleep quality: $_averageSleepQuality", style: _style(),),
        value: _averageQualitySelected,
        onChanged: (bool value) { setState(() { _averageQualitySelected = value;});}
    );
  }

  TextStyle _style() {
    return new TextStyle(fontSize: 18.0);
  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 18.0,
      indent: 0.0,
    );
  }

  void _loadData() {

    var ref = Database.sleepEntriesReference();

    List<SleepRating> ratings = new List<SleepRating>();

    ref.onChildAdded.listen((Event event) {
      ratings.add(SleepRating.fromSnapshot(event.snapshot));
    });

    if(ratings.length == 0) {
      return;
    }

    //Put in after first layout
//    if(ratings.length == 0) {
//      Utilities.showSnackbarMessage(context, "You've not rated your sleep enough to see any statistics!");
//      return;
//    }

    //Here I can filter on date range selected

    //Calculate average time to bed
    int sumOfTimesToBed = 0;
    for(var rating in ratings) {
      sumOfTimesToBed += Utilities.calculateMinutesFromTimeString(rating.getTimeToBed());
    }
    _averageTimeToBed = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(sumOfTimesToBed));

    //Calculate average time to sleep
    int sumOfTimesToSleep = 0;
    for(var rating in ratings) {
      sumOfTimesToSleep += Utilities.calculateMinutesFromTimeString(rating.getGotToSleepTime());
    }
    _averageTimeToSleep = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(sumOfTimesToSleep));

    //Calculate average time lying awake
    int differenceToBedAndToSleep = sumOfTimesToSleep - sumOfTimesToBed;
    _averageTimeLyingAwake = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(differenceToBedAndToSleep));

    //Calculate average wake up time
    int sumOfWakeUpTimes = 0;
    for(var rating in ratings) {
      sumOfWakeUpTimes += Utilities.calculateMinutesFromTimeString(rating.getWokeUpTime());
    }
    _averageWakeUpTime = Utilities.formTimeStringFromMinutesInADay(Utilities.minuteInADayOutOfNDaysInMinutes(sumOfWakeUpTimes));

    //Calculate average time asleep every night
    int differenceWakeUpToGoToSleep = sumOfWakeUpTimes - sumOfTimesToSleep;
    _averageSleepPerNight = Utilities.formHoursAndMinutesStringFromMinutes(Utilities.minuteInADayOutOfNDaysInMinutes(differenceWakeUpToGoToSleep));

    //Calculate average quality from ratings
    int totalQuality = 0;
    for(var rating in ratings) {
      totalQuality += int.tryParse(rating.getQuality());
    }
    int quality = (totalQuality / ratings.length).toInt();
    _averageSleepQuality = quality.toString();

    setState(() {
      //Setting state for all above strings
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