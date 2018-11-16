
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
      title: new Text(_formatJournalDate(_journalEntry.getDate()), style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(
          onPressed: (){ _journalingContext.navigateToViewEntryView(_journalEntry); },
          child: new Icon(Icons.arrow_forward)),
    );

  }

  String _formatJournalDate(String journalDate) {

    StringBuffer formatted = new StringBuffer();

    var numeralsToMonths = {
      "1": "January",
      "2": "February",
      "3": "March",
      "4": "April",
      "5": "May",
      "6": "June",
      "7": "July",
      "8": "August",
      "9": "September",
      "10": "October",
      "11": "November",
      "12": "December",
    };

    List<String> parts = journalDate.split('/');


    formatted.write(numeralsToMonths[parts.elementAt(0)]);
    formatted.write(" ");
    formatted.write(parts.elementAt(1));
    int day = int.parse(parts.elementAt(1));
    switch(day) {
      case 1:
      case 21:
      case 31:
        formatted.write("st");
        break;
      case 2:
      case 22:
        formatted.write("nd");
        break;
      case 3:
      case 23:
        formatted.write("rd");
        break;
      case 4:
      case 24:
        formatted.write("th");
    }

    formatted.write(", ");
    formatted.write(parts.elementAt(2));

    return formatted.toString();
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