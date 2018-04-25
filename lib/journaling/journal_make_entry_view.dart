
import 'package:flutter/material.dart';


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