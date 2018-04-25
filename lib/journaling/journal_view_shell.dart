
import 'package:flutter/material.dart';

import 'journal_entry_list_view.dart';
import 'journal_make_entry_view.dart';


class JournalView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new JournalViewState();

}

class JournalViewState extends State<JournalView> with SingleTickerProviderStateMixin {

  PageController _pageController;

  String _pageTitle = "Journal Entries";
  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text(_pageTitle)),

      body: new PageView(

        controller: _pageController,

        children: <Widget>[

          new JournalEntryListView(animateToMakeAnEntryPage),

          new MakeEntryView(animateToJournalEntryPage)

        ],

      ),
    );
    

  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  void animateToJournalEntryPage() {
    _animateToPage(0);
  }

  void animateToMakeAnEntryPage() {
    _animateToPage(1);
  }

  void setPageName(int page) {
    setState(() {
      if(page == 0) {
        _pageTitle = "Journal Entries";
      } else if(page == 1) {
        _pageTitle = "Make An Entry";
      }
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
