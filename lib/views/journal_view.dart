
import 'package:flutter/material.dart';

import 'package:mood_map/journaling/entry_list_view.dart';
import 'package:mood_map/journaling/make_entry_view.dart';
import 'package:mood_map/journaling/view_entry_view.dart';

import 'package:mood_map/components/journaling_context.dart';

class JournalView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new JournalViewState();

}

class JournalViewState extends State<JournalView> with SingleTickerProviderStateMixin {

  static PageController _pageController;

  JournalingContext _journalingContext;

  JournalViewState() {
    _journalingContext = new JournalingContext(
        animateToJournalEntryPage,
        animateToMakeAnEntryPage,
        animateToViewAnEntryPage);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[

          new JournalEntryListView(_journalingContext),

          new MakeEntryView(_journalingContext),

          new ViewEntryView(_journalingContext)

        ],

      ),

      resizeToAvoidBottomPadding: false,
    );
    

  }

  static void _animateToPage(int page) {
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

  static void animateToViewAnEntryPage() {
    _animateToPage(2);
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
