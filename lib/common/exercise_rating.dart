
import 'package:firebase_database/firebase_database.dart';

class ExerciseSettings {

  String key;

  String didExercise;
  String type;
  String duration;

  DateTime date;

  ExerciseSettings(this.didExercise, this.type, this.duration);

  ExerciseSettings.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      didExercise = snapshot.value['did_exercise'],
      type = snapshot.value['exercise_type'],
      duration = snapshot.value['duration'],
      date = snapshot.value['date'];

  toJson() {
    return {
      "did_exercise" : didExercise,
      "exercise_type" : type,
      "duration" : duration,
      "date" : DateTime.now()
    };
  }

}