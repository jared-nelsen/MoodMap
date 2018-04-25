
import 'package:flutter/material.dart';


class JournalEntryListView extends StatefulWidget {

  final Function _makeEntryFunction;

  JournalEntryListView(this._makeEntryFunction);

  @override
  State<StatefulWidget> createState() => new JournalEntryListViewState(_makeEntryFunction);

}

class JournalEntryListViewState extends State<JournalEntryListView> {

  Function _makeEntryFunction;

  JournalEntryListViewState(this._makeEntryFunction);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _makeEntryFunction
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}