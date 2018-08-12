
import 'package:flutter/material.dart';

import 'package:mood_map/journaling/entry_list_view.dart';
import 'package:mood_map/journaling/make_entry_view.dart';

import 'package:mood_map/components/journaling_context.dart';

class JournalView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new JournalViewState();

}

class JournalViewState extends State<JournalView> with SingleTickerProviderStateMixin {

  static PageController _pageController;

  static String _pageTitle = "Journal Entries";

  JournalingContext _journalingContext = new JournalingContext(animateToJournalEntryPage, animateToMakeAnEntryPage);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text(_pageTitle)),

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[

          new JournalEntryListView(_journalingContext),

          new MakeEntryView(_journalingContext),

        ],

      ),

      resizeToAvoidBottomPadding: false,
    );
    

  }

  static void _animateToPage(int page) {
    setPageName(page);
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  static void animateToJournalEntryPage() {
    _animateToPage(0);
  }

  static void animateToMakeAnEntryPage() {
    _animateToPage(1);
  }

  static void setPageName(int page) {

    if(page == 0) {
      _pageTitle = "Journal Entries";
    } else if(page == 1) {
      _pageTitle = "Make A Journal Entry";
    }

  }

  void state() {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}
