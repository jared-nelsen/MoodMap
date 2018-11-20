
import 'package:firebase_database/firebase_database.dart';

class Database {

  static DatabaseReference userDataReference() {
    return FirebaseDatabase.instance.reference().child("user_data");
  }

  static DatabaseReference userDataPushReference() {
    return FirebaseDatabase.instance.reference().child("user_data").push();
  }

  static DatabaseReference categoriesReference() {
    return FirebaseDatabase.instance.reference().child("emotion_categories");
  }

  static DatabaseReference categoriesPushReference() {
    return FirebaseDatabase.instance.reference().child("emotion_categories").push();
  }

  static DatabaseReference emotionRatingReference() {
    return FirebaseDatabase.instance.reference().child("emotion_ratings");
  }

  static DatabaseReference emotionRatingPushReference() {
    return FirebaseDatabase.instance.reference().child("emotion_ratings").push();
  }

  static DatabaseReference specificsReference() {
    return FirebaseDatabase.instance.reference().child("emotion_specifics");
  }

  static DatabaseReference specificsPushReference() {
    return FirebaseDatabase.instance.reference().child("emotion_specifics").push();
  }

  static DatabaseReference emotionsReference() {
    return FirebaseDatabase.instance.reference().child("emotions");
  }

  static DatabaseReference emotionsPushReference() {
    return FirebaseDatabase.instance.reference().child("emotions").push();
  }

  static DatabaseReference exerciseReference() {
    return FirebaseDatabase.instance.reference().child("exercise_entries");
  }

  static DatabaseReference exercisePushReference() {
    return FirebaseDatabase.instance.reference().child("exercise_entries").push();
  }

  static DatabaseReference journalEntriesReference() {
    return FirebaseDatabase.instance.reference().child("journal_entries");
  }

  static DatabaseReference journalEntriesPushReference() {
    return FirebaseDatabase.instance.reference().child("journal_entries").push();
  }

  static DatabaseReference medicationsReference() {
    return FirebaseDatabase.instance.reference().child("medications");
  }

  static DatabaseReference medicationsPushReference() {
    return FirebaseDatabase.instance.reference().child("medications").push();
  }

  static DatabaseReference reminderSettingsReference() {
    return FirebaseDatabase.instance.reference().child('reminder_settings');
  }

  static DatabaseReference sleepEntriesReference() {
    return FirebaseDatabase.instance.reference().child("sleep_entries");
  }

  static DatabaseReference sleepEntriesPushReference() {
    return FirebaseDatabase.instance.reference().child("sleep_entries").push();
  }

}