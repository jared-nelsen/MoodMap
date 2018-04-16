import 'package:flutter/material.dart';

import 'manage_reminders_view.dart';
import 'manage_emotions_view.dart';

class ManageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageViewState();

}

class ManageViewState extends State<ManageView> with SingleTickerProviderStateMixin {

  ///The tab controller for the Manage Emotions and Reminders pages
  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    ///The Management Scaffold
    return new Scaffold(
      backgroundColor: Colors.green,

      ///The Management Tabs
      appBar: new TabBar(
        controller: _tabController,
        tabs: <Widget>[
          new Tab(text: "Emotions",),
          new Tab(text: "Reminders",)
        ],

      ),

      ///The Management Tab viewports
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[

          new ManageEmotionsView(),
          new ManageRemindersView()

        ],
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
