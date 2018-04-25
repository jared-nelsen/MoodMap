import 'package:flutter/material.dart';

import 'manage_view_shell.dart';
import 'rate_view.dart';
import 'package:mood_map/journaling/journal_view_shell.dart';
import 'track_view.dart';

class ApplicationShell extends StatefulWidget {

  @override
  State createState() => new ApplicationShellState();

}

class ApplicationShellState extends State<ApplicationShell> {

  ///The Application Shell State controller
  PageController _pageController;

  ///The index of the current page
  ///0: Manage
  ///1: Track
  ///2: Rate
  int _pageIndex = 0;


  @override
  Widget build(BuildContext context) {

    //The top level scaffold of the app
    return new Scaffold(
      appBar: new AppBar(title: new Text("Mood Map")),

      ///The body of the app
      body: new PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[

          ///The Emotion Manager
          new ManageView(),

          ///The Emotion Tracker
          new TrackView(),

          ///The Emotion Rater
          new RateView(),

          ///The Journaling View
          new JournalView()

        ],
      ),

      ///The navigation bar between the views
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          onTap: navigationTapped,
          currentIndex: _pageIndex,
          items: [
            new BottomNavigationBarItem(icon: new Icon(Icons.apps), title: new Text("Manage")),
            new BottomNavigationBarItem(icon: new Icon(Icons.multiline_chart), title: new Text("Track")),
            new BottomNavigationBarItem(icon: new Icon(Icons.check_box), title: new Text("Rate")),
            new BottomNavigationBarItem(icon: new Icon(Icons.border_color), title: new Text("Journal")),
          ]
      ),
    );

  }


  ///One of the items on the navigation bar has been tapped
  void navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  ///Sets the index of the current page when it is changed via the navigation bar
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

}