import 'package:flutter/material.dart';

import 'manage_view.dart';

import 'rate_view.dart';

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

  AppBar _bar = new AppBar(title: new Text("Mood Map"),);

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

  @override
  Widget build(BuildContext context) {

    //The top level scaffold of the app
    return new Scaffold(
      appBar: _bar,

      ///The body of the app
      body: new PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[

          ///The Emotion Manager
          new ManageView(),

          ///The Emotion Tracker
          new Container(color: Colors.blue),

          ///The Emotion Rater
          new RateView(),

        ],
      ),

      ///The navigation bar between the views
      bottomNavigationBar: new BottomNavigationBar(
          onTap: navigationTapped,
          currentIndex: _pageIndex,
          items: [
            new BottomNavigationBarItem(icon: new Icon(Icons.apps), title: new Text("Manage")),
            new BottomNavigationBarItem(icon: new Icon(Icons.multiline_chart), title: new Text("Track")),
            new BottomNavigationBarItem(icon: new Icon(Icons.check_box), title: new Text("Rate")),
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


}

//All I have to do is set the title with a switch statement at this widget level when we change the page now that app bar is a
//field.