import 'package:flutter/material.dart';

class ManageView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageViewState();

}

class ManageViewState extends State<ManageView> with SingleTickerProviderStateMixin {

  ///The tab controller for the Manage Emotions and Reminders pages
  TabController _tabController;

  @override
  Widget build(BuildContext context) {

    return new Container();

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
