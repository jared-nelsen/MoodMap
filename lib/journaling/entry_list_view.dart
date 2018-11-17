
import 'package:flutter/material.dart';

import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/journal_entry_list_item.dart';
import 'package:mood_map/components/journaling_context.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:after_layout/after_layout.dart';

import 'package:mood_map/utilities/database.dart';
import 'package:mood_map/utilities/utilities.dart';

class JournalEntryListView extends StatefulWidget {

  final JournalingContext _journalingContext;

  JournalEntryListView(this._journalingContext);

  @override
  State<StatefulWidget> createState() => new JournalEntryListViewState(_journalingContext);

}

class JournalEntryListViewState extends State<JournalEntryListView> with AfterLayoutMixin<JournalEntryListView> {

  final DatabaseReference firebase = Database.journalEntriesReference();

  JournalingContext _journalingContext;

  List<JournalEntryListItem> _journalEntries = new List();

  JournalEntryListViewState(JournalingContext journalingContext) {
    this._journalingContext = journalingContext;

    firebase.onChildAdded.listen(_retrieveFromDatabase);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Utilities.showPageInfoSnackbarMessage(context, "You can delete an entry by long pressing it");
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text("Journal Entries")),

      body: new ListView(
        children: _journalEntries.map((JournalEntryListItem entry) {
          return entry;
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){ _journalingContext.navigateToMakeEntryListView(new JournalEntry());},
          icon: new Icon(Icons.add),
          label: new Text("Add an Entry")),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );

  }
  
  void _retrieveFromDatabase(Event event) {
    
    setState(() {
      
      JournalEntry entry = JournalEntry.fromSnapshot(event.snapshot);
      
      bool alreadyThere = false;
      for(var listItem in _journalEntries) {
        if(listItem.dbKey == entry.getKey()) {
          alreadyThere = true;
          break;
        }
      }
      
      if(!alreadyThere) {
        _journalEntries.add(new JournalEntryListItem(entry.getKey(), _journalingContext, entry, _removeJournalEntry));
      }
      
    });
    
  }

  void _removeJournalEntry(String journalEntryDbKey) async {

    await showDialog(context: context,
        builder: (BuildContext context) {

          return new SimpleDialog(
            title: new Text("Are you sure you would like to remove this journal entry?"),
            children: <Widget>[

              new Column(
                children: <Widget>[
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      new SimpleDialogOption(
                        child: const Text("Yes", style: const TextStyle(color: Colors.green),),
                        onPressed: (){

                          setState(() {
                            int index = 0;
                            for(int i = 0; i < _journalEntries.length; i++) {
                              JournalEntryListItem item = _journalEntries.elementAt(i);
                              if(journalEntryDbKey == item.getDbKey()) {
                                index = i;
                                break;
                              }
                            }

                            //Remove from the database
                            JournalEntryListItem journalEntry = _journalEntries.elementAt(index);
                            Database.journalEntriesReference().child(journalEntry.getDbKey()).remove();

                            _journalEntries.removeAt(index);

                            _confirm("Journal Entry removed");

                          });

                          Navigator.pop(context);
                        },
                      ),
                      new SimpleDialogOption(
                        child: const Text("No"),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )

                    ],
                  )
                ],
              )

            ],
          );
        }
    );

  }

  void _confirm(String confirmation) {
    Utilities.showSnackbarMessage(context, confirmation);
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