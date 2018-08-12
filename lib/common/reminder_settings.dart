
import 'package:firebase_database/firebase_database.dart';

class ReminderSettings {

  String _dbKey;

  bool _remindingEmotions;
  String _emotionInterval;
  String _emotionStarting;
  String _emotionEnding;

  bool _remindingSleep;
  String _sleepRemindTime;

  bool _remindingExercise;
  String _exerciseRemindTime;

  ReminderSettings(
      this._remindingEmotions,
      this._emotionInterval,
      this._emotionStarting,
      this._emotionEnding,
      this._remindingSleep,
      this._sleepRemindTime,
      this._remindingExercise,
      this._exerciseRemindTime);

  ReminderSettings.fromSnapshot(DataSnapshot snapshot) :
      _dbKey = snapshot.key,
      _remindingEmotions = snapshot.value['reminding_emotions'],
      _emotionInterval = snapshot.value['emotion_interval'],
      _emotionStarting = snapshot.value['emotion_starting'],
      _emotionEnding = snapshot.value['emotion_ending'],
      _remindingSleep = snapshot.value['reminding_sleep'],
      _sleepRemindTime = snapshot.value['sleep_remind_time'],
      _remindingExercise = snapshot.value['reminding_exercise'],
      _exerciseRemindTime = snapshot.value['exercise_remind_time'];

  toJson() {
   return {
     "reminding_emotions": _remindingEmotions,
     "emotion_interval": _emotionInterval,
     "emotion_starting": _emotionStarting,
     "emotion_ending" : _emotionEnding,
     "reminding_sleep": _remindingSleep,
     "sleep_remind_time": _sleepRemindTime,
     "reminding_exercise": _remindingExercise,
     "exercise_remind_time": _exerciseRemindTime
   };
  }

  String getKey() {
    return _dbKey;
  }

  bool getRemindingEmotions() {
    return _remindingEmotions;
  }

  String getEmotionInterval() {
    return _emotionInterval;
  }

  String getEmotionStartTime() {
    return _emotionStarting;
  }

  String getEmotionEndTime() {
    return _emotionEnding;
  }

  bool getRemindingSleep() {
    return _remindingSleep;
  }

  String getSleepReminderTime() {
    return _sleepRemindTime;
  }

  bool getRemindingExercise() {
    return _remindingExercise;
  }

  String getExcerciseRemindTime() {
    return _exerciseRemindTime;
  }

}