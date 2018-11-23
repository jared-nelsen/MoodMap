import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

import 'package:mood_map/utilities/session.dart';

import 'manage_view.dart';
import 'rate_view.dart';
import 'package:mood_map/views/journal_view.dart';
import 'track_view.dart';
import 'health_view.dart';

class AppShellViewController extends StatefulWidget {

  @override
  State createState() => new AppShellViewControllerState();

}

class AppShellViewControllerState extends State<AppShellViewController> with AfterLayoutMixin<AppShellViewController> {

  static PageController _pageController;

  int _pageIndex = 2;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(
        title: new Text("Mood Map"),
        actions: <Widget>[
          //IconButton(icon: new Icon(Icons.settings), onPressed: (){})

          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[

              const PopupMenuItem(child: const Text("Log Out"), value: "T",),

            ],
            
            onSelected: (String s) {

              showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {

                    return SimpleDialog(
                      title: new Text("Are you sure you would like to log out?"),
                      children: <Widget>[

                        new Column(
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[

                                SimpleDialogOption(
                                  child: new Text("Yes", style: new TextStyle(color: Colors.green),),
                                  onPressed: () {

                                    Navigator.pop(context);
                                    Session.logOut();
                                    
                                    },

                                ),

                                SimpleDialogOption(
                                  child: new Text("No"),
                                  onPressed: () {

                                    Navigator.pop(context);

                                    },
                                )

                              ],
                            )
                          ],
                        ),

                      ],
                    );

                  });
            },
                
          )

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

      resizeToAvoidBottomPadding: false,
    );

  }

  static void _navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  static void navigateToManageView() {
    _navigationTapped(0);
  }

  static void navigateToTrackView() {
    _navigationTapped(1);
  }

  static void navigateToRateView() {
    _navigationTapped(2);
  }

  static void navigateToHealthView() {
    _navigationTapped(3);
  }

  static void navigateToJournalView() {
    _navigationTapped(4);
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

  @override
  void afterFirstLayout(BuildContext context) {
    navigateToRateView();
  }

}