
import 'package:flutter/material.dart';

class ManageRemindersView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageRemindersViewState();

}

class ManageRemindersViewState extends State<ManageRemindersView> {

  @override
  Widget build(BuildContext context) {

    return new Container(

      child: new Row(

        children: <Widget>[
          new Expanded(

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                _buildInformationRow(),
                _buildReminderRow(),

              ],
            )

          )
        ],

      )

      );
  }

  Widget _buildInformationRow() {

    return new Container(
      padding: const EdgeInsets.all(10.0),
      child: new Row(

        children: <Widget>[

          new Column(
            children: <Widget>[

              new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  //"Mood Map can remind you to rate\nyour emotions on a regular basis",
                  "This app can remind you to do stuff\non a regular basis",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )
                ),

              )

            ],
          )

        ],

      ),

    );
  }

  Widget _buildReminderRow() {

    return new Container(

      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          new Column(
            children: <Widget>[

              new Container(

                child: new Text(
                    "Remind me",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    )
                ),

              )

            ],
          ),

          new Column(
            children: <Widget>[

              new Container(

                  child: new DropdownButton<String>(
                      style: new TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                      items: <String>["Never", "Daily", "Hourly", "Every 30 Minutes"].map((String value) {
                        return new DropdownMenuItem <String>(
                            value: value,
                            child: new Text(value)
                        );
                      }).toList(),
                      onChanged: null
                  )
              )

            ],
          )

        ],
      ),

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

class ManageSettingsView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageSettingsViewState();

}

class ManageSettingsViewState extends State<ManageSettingsView> with SingleTickerProviderStateMixin {

  ///The tab controller for the Manage Emotions and Reminders pages
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      ///The views for the different time selection modalities
      body: new TabBarView(
        controller: _tabController,
        children: null,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}