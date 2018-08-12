
import 'package:flutter/material.dart';

import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/journaling_context.dart';

class JournalEntryListItem extends StatefulWidget {

  String dbKey;

  JournalingContext _journalingContext;

  JournalEntry _journalEntry;

  JournalEntryListItem(this.dbKey, this._journalingContext, this._journalEntry);

  @override
  State<StatefulWidget> createState() => new JournalEntryListItemState(this._journalingContext, this._journalEntry);
}

class JournalEntryListItemState extends State<JournalEntryListItem> {

  JournalingContext _journalingContext;

  JournalEntry _journalEntry;

  JournalEntryListItemState(this._journalingContext, this._journalEntry);

  @override
  Widget build(BuildContext context) {

    return new ListTile(
      title: new Text(_journalEntry.getDate(), style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _journalingContext.navigateToMakeEntryListView(_journalEntry); },
          child: new Icon(Icons.arrow_forward)),
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