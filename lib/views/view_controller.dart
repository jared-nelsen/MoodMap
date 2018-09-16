import 'package:flutter/material.dart';

import 'manage_view.dart';
import 'rate_view.dart';
import 'package:mood_map/views/journal_view.dart';
import 'track_view.dart';
import 'health_view.dart';

import 'package:mood_map/utilities/app_compass.dart';

class ViewController extends StatefulWidget {

  final AppCompass _appCompass;

  ViewController(this._appCompass);

  @override
  State createState() => new ViewControllerState(_appCompass);

}

class ViewControllerState extends State<ViewController> {

  AppCompass _appCompass;

  static PageController _pageController;

  int _pageIndex = 0;

  ViewControllerState(this._appCompass);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Mood Map"),
        actions: <Widget>[
          IconButton(icon: new Icon(Icons.settings), onPressed: (){})
        ],
      ),

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: <Widget>[

          new ManageView(),
          new TrackView(),
          new RateView(),
          new HealthView(),
          new JournalView()

        ],
      ),

      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          onTap: _navigationTapped,
          currentIndex: _pageIndex,
          items: [
            new BottomNavigationBarItem(icon: new Icon(Icons.apps), title: new Text("Manage")),
            new BottomNavigationBarItem(icon: new Icon(Icons.multiline_chart), title: new Text("Track")),
            new BottomNavigationBarItem(icon: new Icon(Icons.check_box), title: new Text("Emotions")),
            new BottomNavigationBarItem(icon: new Icon(Icons.person_add), title: new Text("Health")),
            new BottomNavigationBarItem(icon: new Icon(Icons.border_color), title: new Text("Journal")),
          ]
      ),
    );

  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();

    //The initial screen is the Emotions Rating Screen
    _pageIndex = 2;
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

}