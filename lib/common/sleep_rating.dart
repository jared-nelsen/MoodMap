
import 'package:firebase_database/firebase_database.dart';

class SleepRating {

  String key;

  String timeToBed;
  String gotToSleepTime;
  String wokeUpTime;
  String quality;

  DateTime date;

  SleepRating(this.timeToBed, this.gotToSleepTime, this.wokeUpTime, this.quality);

  SleepRating.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      timeToBed = snapshot.value['time-to-bed'],
      gotToSleepTime = snapshot.value['got-to-sleep-time'],
      wokeUpTime = snapshot.value['wake-up-time'],
      quality = snapshot.value['quality'],
      date = DateTime.parse(snapshot.value['date']);

  toJson() {
    return {
      "time-to-bed" : timeToBed,
      "got-to-sleep-time": gotToSleepTime,
      "wake-up-time" : wokeUpTime,
      "quality" : quality,
      "date" : DateTime.now().toIso8601String()
    };
  }

  String getTimeToBed() {
    return timeToBed;
  }

  String getGotToSleepTime() {
    return gotToSleepTime;
  }

  String getWokeUpTime() {
    return wokeUpTime;
  }

  String getQuality() {
    return quality;
  }

}