
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/health_tracking/views/exercise_tracking_view.dart';
import 'package:mood_map/tracking/health_tracking/views/sleep_tracking_view.dart';

class HealthTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _HealthTrackingViewState();

}

class _HealthTrackingViewState extends State<HealthTrackingView> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

        labelColor: Colors.black,
        controller: _tabController,

        tabs: <Widget>[
          new Container(height: 40.0, child: new Tab(text: "Sleep",),),
          new Container(height: 40.0, child: new Tab(text: "Exercise",))
        ],

      ),

      body: new TabBarView(
        controller: _tabController,

        children: <Widget>[

          new SleepTrackingView(),
          new ExerciseTrackingView()

        ],

        physics: NeverScrollableScrollPhysics(),
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
  }

}