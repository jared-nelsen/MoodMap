import 'package:flutter/material.dart';

class ManageRemindersView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageRemindersViewState();

}

class ManageRemindersViewState extends State<ManageRemindersView> {

  bool _remindingEmotions;
  var _times = ["Daily", "Hourly", "Every 30 Minutes", "Every 15 Minutes"];

  @override
  Widget build(BuildContext context) {

    return new SingleChildScrollView (
      child: new Column(
        children: <Widget>[
          _buildEmotionSettings()
        ],
      ),
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
                  child: new Text("Emotions", style: new TextStyle(fontSize: 22.0),),
                ),),
            new Column(children: <Widget>[
              new Switch(value: true, onChanged: (bool on) { _remindingEmotions = on; })
            ],)
          ],
        ),
        new Divider(
          color: Colors.black,
          height: 5.0,
          indent: 0.0,
        ),
        new Row(
          children: <Widget>[
            new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 10.0),
                  child: new Text("Remind Me", style: new TextStyle(fontSize: 18.0),),)),
            new DropdownButton(
                items: _times.map((String time) {
                  return new DropdownMenuItem(child: new Text(time));
                }).toList(),
                onChanged: null)
          ],
        ),
        new Row()
      ],
    );
  }

  Widget _buildSleepSettings() {

  }

  Widget _buildExerciseEvents() {

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