
import 'package:flutter/material.dart';

import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/journal_entry_list_item.dart';
import 'package:mood_map/components/journaling_context.dart';

import 'package:firebase_database/firebase_database.dart';

class JournalEntryListView extends StatefulWidget {

  final JournalingContext _journalingContext;

  JournalEntryListView(this._journalingContext);

  @override
  State<StatefulWidget> createState() => new JournalEntryListViewState(_journalingContext);

}

class JournalEntryListViewState extends State<JournalEntryListView> {

  final DatabaseReference firebase = FirebaseDatabase.instance.reference().child("journal_entries");

  JournalingContext _journalingContext;

  List<JournalEntryListItem> _entries = new List();

  JournalEntryListViewState(JournalingContext journalingContext) {
    this._journalingContext = journalingContext;

    firebase.onChildAdded.listen(_retrieveFromDatabase);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new ListView(
        children: _entries.map((JournalEntryListItem entry) {
          return entry;
        }).toList(),
      ),

      floatingActionButton: new FloatingActionButton(
          onPressed:(){ _journalingContext.navigateToMakeEntryListView(new JournalEntry()); },
          child: new Icon(Icons.add),
      ),

    );

  }
  
  void _retrieveFromDatabase(Event event) {
    
    setState(() {
      
      JournalEntry entry = JournalEntry.fromSnapshot(event.snapshot);
      
      bool alreadyThere = false;
      for(var listItem in _entries) {
        if(listItem.dbKey == entry.getKey()) {
          alreadyThere = true;
          break;
        }
      }
      
      if(!alreadyThere) {
        _entries.add(new JournalEntryListItem(entry.getKey(), _journalingContext, entry));
      }
      
    });
    
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