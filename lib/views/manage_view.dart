import 'package:flutter/material.dart';

import 'package:mood_map/management/manage_reminders.dart';
import 'package:mood_map/management/manage_medication.dart';

class ManageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageViewState();

}

class ManageViewState extends State<ManageView> with SingleTickerProviderStateMixin {

  ///The tab controller for the Manage Emotions and Reminders pages
  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new TabBar(

        labelColor: Colors.black,

        controller: _tabController,
          tabs: [
            new Tab(text: "Reminders",),
            new Tab(text: "Medications")
          ]),

      body: new TabBarView(
        controller: _tabController,

          children: [

            new ManageRemindersView(),
            new ManageMedicationView()

          ]),

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
