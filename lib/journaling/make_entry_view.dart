
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
    return null;
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