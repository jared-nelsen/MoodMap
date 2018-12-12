
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/health_tracking/views/exercise_views/exercise_proportion_view.dart';
import 'package:mood_map/tracking/health_tracking/views/exercise_views/exercise_timeline_view.dart';

class ExerciseTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ExerciseTrackingViewState();

}

class _ExerciseTrackingViewState extends State<ExerciseTrackingView> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

        labelColor: Colors.black,

        controller: _tabController,
        tabs: <Widget>[
          new Container(height: 40.0, child: new Tab(text: "Proportion",),),
          new Container(height: 40.0, child: new Tab(text: "Timeline",))
        ],

      ),

      body: new TabBarView(
        controller: _tabController,

        children: <Widget>[

          new ExerciseProportionView(),
          new ExerciseTimelineView()

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
    _tabController.dispose();
  }

}