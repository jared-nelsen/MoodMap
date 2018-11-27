
import 'package:firebase_database/firebase_database.dart';

class SleepSettings {

  String key;

  String timeToBed;
  String gotToSleep;
  String wokeUp;
  String quality;

  DateTime date;

  SleepSettings(this.timeToBed, this.gotToSleep, this.wokeUp, this.quality);

  SleepSettings.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      timeToBed = snapshot.value['time_to_bed'],
      gotToSleep = snapshot.value['got_to_sleep'],
      wokeUp = snapshot.value['woke_up'],
      quality = snapshot.value['quality'],
      date = snapshot.value['date'];

  toJson() {
    return {
      "time_to_bed" : timeToBed,
      "got_to_sleep": gotToSleep,
      "woke_up" : wokeUp,
      "quality" : quality,
      "date" : DateTime.now()
    };
  }

}