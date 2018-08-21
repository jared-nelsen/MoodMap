
import 'package:mood_map/common/journal_entry.dart';

class JournalingContext {

  Function _navigateEntryListView;
  Function _navigateMakeEntryView;
  Function _navigateViewEntryView;

  JournalEntry _currentJournalEntry;

  JournalingContext(this._navigateEntryListView, this._navigateMakeEntryView, this._navigateViewEntryView);

  JournalEntry getCurrentJournalEntry() {
    return _currentJournalEntry;
  }

  void navigateToEntryListView() {
    Function.apply(_navigateEntryListView, null);
  }

  void navigateToMakeEntryListView(JournalEntry currentEntry){
    _currentJournalEntry = currentEntry;
    Function.apply(_navigateMakeEntryView, null);
  }

  void navigateToViewEntryView(JournalEntry currentEntry) {
    _currentJournalEntry = currentEntry;
    Function.apply(_navigateViewEntryView, null);
  }

}