
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

  SleepRating.fromMap(dynamic map) :
    timeToBed = map['time-to-bed'],
    gotToSleepTime = map['got-to-sleep-time'],
    wokeUpTime = map['wake-up-time'],
    quality = map['quality'],
    date = DateTime.parse(map['date']);

  toJson() {
    return {
      "time-to-bed" : timeToBed,
      "got-to-sleep-time": gotToSleepTime,
      "wake-up-time" : wokeUpTime,
      "quality" : quality,
      "date" : DateTime.now().toIso8601String()
    };
  }

  static List<SleepRating> setOfFromSnapshot(DataSnapshot snapshot) {

    List<SleepRating> ratings = new List<SleepRating>();

    Map<dynamic, dynamic> values = snapshot.value;

    values.forEach((key, values) {
      ratings.add(SleepRating.fromMap(values));
    });

    return ratings;
  }

  DateTime getDate() {
    return date;
  }

  void setDate(DateTime time) {
    this.date = time;
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

enum SleepDimension { TIME_TO_BED,
                      GOT_TO_SLEEP,
                      TIME_LYING_AWAKE,
                      WAKE_UP_TIME,
                      SLEEP_PER_NIGHT,
                      QUALITY }