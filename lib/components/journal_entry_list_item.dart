
import 'package:flutter/material.dart';

import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/journaling_context.dart';

import 'package:mood_map/utilities/utilities.dart';

class JournalEntryListItem extends StatefulWidget {

  String dbKey;

  JournalingContext _journalingContext;

  JournalEntry _journalEntry;

  Function _removeCallback;

  JournalEntryListItem(this.dbKey, this._journalingContext, this._journalEntry, this._removeCallback);

  @override
  State<StatefulWidget> createState() => new JournalEntryListItemState(this.dbKey, this._journalingContext, this._journalEntry, this._removeCallback);

  String getDbKey() {
    return dbKey;
  }

}

class JournalEntryListItemState extends State<JournalEntryListItem> {

  JournalingContext _journalingContext;

  JournalEntry _journalEntry;

  String _dbKey;

  Function _removeCallback;

  JournalEntryListItemState(this._dbKey, this._journalingContext, this._journalEntry, this._removeCallback);

  @override
  Widget build(BuildContext context) {

    return new ListTile(
      title: new Text( Utilities.formatDateNamedMonth(_journalEntry.getDate()), style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _journalingContext.navigateToViewEntryView(_journalEntry); },
          child: new Icon(Icons.arrow_forward)),
      onLongPress: () { _removeCallback(_dbKey); },
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