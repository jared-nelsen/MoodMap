
import 'package:firebase_database/firebase_database.dart';

class ReminderSettings {

  String key;

  bool remindingEmotions;
  String emotionInterval;
  String emotionStarting;

  bool remindingSleep;
  String sleepRemindTime;

  bool remindingExercise;
  String exerciseRemindTime;

  ReminderSettings(this.remindingEmotions, this.emotionInterval,
      this.emotionStarting, this.remindingSleep, this.sleepRemindTime,
      this.remindingExercise, this.exerciseRemindTime);

  ReminderSettings.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      remindingEmotions = snapshot.value['reminding_emotions'],
      emotionInterval = snapshot.value['emotion_interval'],
      emotionStarting = snapshot.value['emotion_starting'],
      remindingSleep = snapshot.value['reminding_sleep'],
      sleepRemindTime = snapshot.value['sleep_remind_time'],
      remindingExercise = snapshot.value['reminding_exercise'],
      exerciseRemindTime = snapshot.value['exercise_remind_time'];

  toJson() {
   return {
     "reminding_emotions": remindingEmotions,
     "emotion_interval": emotionInterval,
     "emotion_starting": emotionStarting,
     "reminding_sleep": remindingSleep,
     "sleep_remind_time": sleepRemindTime,
     "reminding_exercise": remindingExercise,
     "exercise_remind_time": exerciseRemindTime
   };
  }

}