import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import 'package:mood_map/common/reminder_settings.dart';

class ManageRemindersView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageRemindersViewState();

}

class ManageRemindersViewState extends State<ManageRemindersView> {

  var _interval = ["Daily", "Hourly", "Every 30 Minutes", "Every 15 Minutes"];
  String _emotionIntervalValue = "Daily";

  bool _remindingEmotions = true;
  bool _remindingSleep = true;
  bool _remindingExercise = true;
  bool _remindingJournaling = true;

  String _emotionStartTime = _formatTime(new TimeOfDay(hour: 9, minute: 0));
  String _emotionEndTime = _formatTime(new TimeOfDay(hour: 20, minute: 0));
  String _sleepRemindTime = _formatTime(new TimeOfDay(hour: 9, minute: 0));
  String _exerciseRemindTime = _formatTime(new TimeOfDay(hour: 19, minute: 0));
  String _journalingRemindTime = _formatTime(new TimeOfDay(hour: 20, minute: 0));

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new SingleChildScrollView (

        padding: const EdgeInsets.all(10.0),

        child: new Column(
          children: <Widget>[

            _buildTitleBar(),
            _divider(),
            _buildEmotionSettings(),
            _divider(),
            _buildSleepSettings(),
            _divider(),
            _buildExerciseEvents(),
            _divider(),
            _buildJournalingSettings(),


         ],
       ),
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(
            onPressed: _saveSettings,
            child: new Text("Save"))
      ],
    );

  }
  
  Widget _buildTitleBar() {
    
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text("Set up reminders for you to rate your health here"),
                )
            )
          ],
        )
      ],
    );
  }

  Widget _buildEmotionSettings() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Text("Emotion Reminders", style: new TextStyle(fontSize: 22.0),),
                ),),
            new Column(children: <Widget>[
              new Switch(value: _remindingEmotions, onChanged: (bool on) {
                setState(() {
                  _remindingEmotions = on;
                });
              })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Remind me", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new DropdownButton<String>(

                  value: _emotionIntervalValue,

                  items: _interval.map((String time) {
                    return new DropdownMenuItem<String>(value: time, child: new Text(time));
                  }).toList(),

                  onChanged: (String time) {
                    setState(() {
                      _emotionIntervalValue = time;
                    });
                  }

              ),
            )

          ],
        ),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("starting at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_emotionStartTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectEmotionStartTime(context, _emotionStartTime);}
                    ),
              ),
            )

          ],
        ),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("ending at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_emotionEndTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectEmotionEndTime(context, _emotionEndTime);}
                ),
              ),
            )

          ],
        ),

      ],
    );

  }

  Widget _buildSleepSettings() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text("Sleep Reminders", style: new TextStyle(fontSize: 22.0),),
              ),),
            new Column(children: <Widget>[
              new Switch(value: _remindingSleep, onChanged: (bool on) {
                setState(() {
                  _remindingSleep = on;
                });
              })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Rate in the morning at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_sleepRemindTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectSleepTime(context, _sleepRemindTime);}
                ),
            ),


          ],
        ),

      ],
    );

  }

  Widget _buildExerciseEvents() {

    return new Column(
      children: <Widget>[

        new Row (
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text("Exercise Reminders", style: new TextStyle(fontSize: 22.0),),
              ),),
            new Column(children: <Widget>[
              new Switch(value: _remindingExercise, onChanged: (bool on) {
                setState(() {
                  _remindingExercise = on;
                });
              })
            ],)
          ],
        ),

        _divider(),

        new Row(
          children: <Widget>[

            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                child: new Text("Rate in the evening at", style: new TextStyle(fontSize: 18.0),),),
            ),

            new Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
              child: new RaisedButton(
                  child: new Text(_exerciseRemindTime, style: new TextStyle(fontSize: 18.0),),
                  onPressed: () {_selectSleepTime(context, _exerciseRemindTime);}
              ),
            ),


          ],
        ),

      ],
    );

  }

  Widget _buildJournalingSettings() {

      return new Column(
        children: <Widget>[

          new Row (
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Text("Journaling Reminders", style: new TextStyle(fontSize: 22.0),),
                ),),
              new Column(children: <Widget>[
                new Switch(value: _remindingJournaling, onChanged: (bool on) {
                  setState(() {
                    _remindingJournaling = on;
                  });
                })
              ],)
            ],
          ),

          _divider(),

          new Row(
            children: <Widget>[

              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                  child: new Text("Rate in the evening at", style: new TextStyle(fontSize: 18.0),),),
              ),

              new Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                child: new RaisedButton(
                    child: new Text(_journalingRemindTime, style: new TextStyle(fontSize: 18.0),),
                    onPressed: () {_selectJournalingTime(context, _journalingRemindTime);}
                ),
              ),


            ],
          ),

        ],
      );

  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 18.0,
      indent: 0.0,
    );
  }

  Future<Null> _selectEmotionStartTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _emotionStartTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectEmotionEndTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _emotionEndTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectSleepTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _sleepRemindTime = _formatTime(picked);
      });
    }

  }

  Future<Null> _selectJournalingTime(BuildContext context, String time) async {

    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());

    if(picked != null) {
      setState(() {
        _journalingRemindTime = _formatTime(picked);
      });
    }

  }

  void _saveSettings() {

    var ref = FirebaseDatabase.instance.reference().child('reminder_settings');

    ReminderSettings settings = new ReminderSettings(
        _remindingEmotions,
        _emotionIntervalValue,
        _emotionStartTime,
        _emotionEndTime,
        _remindingSleep,
        _sleepRemindTime,
        _remindingExercise,
        _exerciseRemindTime,
        _remindingJournaling,
        _journalingRemindTime);

    ref.set(settings.toJson());

  }

  void _loadSettings() {

    FirebaseDatabase.instance.reference().child("reminder_settings").once().then((DataSnapshot snapshot){

      ReminderSettings settings = ReminderSettings.fromSnapshot(snapshot);

      setState(() {

        _emotionIntervalValue = settings.getEmotionInterval();

        _remindingEmotions = settings.getRemindingEmotions();
        _remindingSleep = settings.getRemindingSleep();
        _remindingExercise = settings.getRemindingExercise();
        _remindingJournaling = settings.getRemindingJournaling();

        _emotionStartTime = settings.getEmotionStartTime();
        _emotionEndTime = settings.getEmotionEndTime();
        _sleepRemindTime = settings.getSleepReminderTime();
        _exerciseRemindTime = settings.getExcerciseRemindTime();
        _journalingRemindTime = settings.getJournalingRemindTime();

      });

    });

  }

  static String _formatTime(TimeOfDay time) {
    var buffer = new StringBuffer();

    buffer.write(time.hourOfPeriod);
    buffer.write(":");

    if(time.minute == 0) {
      buffer.write("00");
    } else if(time.minute <= 9 && time.minute >= 1) {
      buffer.write("0");
      buffer.write(time.minute);
    } else {
      buffer.write(time.minute);
    }

    buffer.write(" ");

    if(time.period == DayPeriod.am) {
      buffer.write("AM");
    } else {
      buffer.write("PM");
    }

    return buffer.toString();
  }

  @override
  void initState() {
    super.initState();

    _loadSettings();
  }

  @override
  void dispose() {
    super.dispose();
  }

}