
import 'package:flutter/material.dart';

import 'entry_components/journal_entry_box.dart';


class MakeEntryView extends StatefulWidget {

  final Function _journalEntryFunction;

  MakeEntryView(this._journalEntryFunction);

  @override
  State<StatefulWidget> createState() => new MakeEntryState(_journalEntryFunction);

}

class MakeEntryState extends State<MakeEntryView> {

  Function _journalEntryFunction;

  MakeEntryState(this._journalEntryFunction);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new ListView(
        children: <Widget>[
          new JournalEntryBox("Toot", "write", new Size(100.0, 100.0)),
          new JournalEntryBox("Toot", "write", new Size(100.0, 100.0)),
        ],
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: _journalEntryFunction, child: new Text("Back"))
      ],

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