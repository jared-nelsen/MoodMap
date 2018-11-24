
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/health_tracking/views/sleep_views/sleep_proportion_view.dart';
import 'package:mood_map/tracking/health_tracking/views/sleep_views/sleep_timeline_view.dart';

class SleepTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _SleepTrackingViewState();

}

class _SleepTrackingViewState extends State<SleepTrackingView> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

        labelColor: Colors.black,

        controller: _tabController,
        tabs: <Widget>[
          new Tab(text: "Proportion",),
          new Tab(text: "Timeline",)
        ],

      ),

      body: new TabBarView(
        controller: _tabController,

        children: <Widget>[

          new SleepProportionView(),
          new SleepTimelineView()

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