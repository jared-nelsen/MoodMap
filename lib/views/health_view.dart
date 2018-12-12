import 'package:flutter/material.dart';

import 'package:mood_map/health/exercise_rate.dart';
import 'package:mood_map/health/sleep_rate.dart';

class HealthView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new HealthViewState();

}

class HealthViewState extends State<HealthView> with SingleTickerProviderStateMixin {

  ///The tab controller for the Manage Emotions and Reminders pages
  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

          labelColor: Colors.black,

          controller: _tabController,
          tabs: [
            new Tab(text: "Sleep",),
            new Tab(text: "Exercise")
          ]),

      body: new TabBarView(
          controller: _tabController,

          children: [

            new SleepView(),
            new ExerciseView()

          ],

          physics: NeverScrollableScrollPhysics(),
      ),

      resizeToAvoidBottomPadding: false,

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