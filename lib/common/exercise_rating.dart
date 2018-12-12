
import 'package:firebase_database/firebase_database.dart';

class ExerciseRating {

  String key;

  String rating;
  String type;
  String duration;

  DateTime date;

  ExerciseRating(this.rating, this.type, this.duration);

  ExerciseRating.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      rating = snapshot.value['rating'],
      type = snapshot.value['exercise_type'],
      duration = snapshot.value['duration'],
      date = DateTime.parse(snapshot.value['date']);

  toJson() {
    return {
      "rating" : rating,
      "exercise_type" : type,
      "duration" : duration,
      "date" : DateTime.now().toIso8601String()
    };
  }

}