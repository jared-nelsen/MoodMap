
import 'package:firebase_database/firebase_database.dart';

class ExerciseRating {

  String key;

  String rating;
  String type;
  String duration;

  DateTime date;

  ExerciseRating(this.rating, this.type, this.duration, {this.date});

  ExerciseRating.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      rating = snapshot.value['rating'],
      type = snapshot.value['exercise_type'],
      duration = snapshot.value['duration'],
      date = DateTime.parse(snapshot.value['date']);

  ExerciseRating.fromMap(dynamic map) :
      rating = map['rating'],
      type = map['exercise_type'],
      duration = map['duration'],
      date = DateTime.parse(map['date']);

  toJson() {
    return {
      "rating" : rating,
      "exercise_type" : type,
      "duration" : duration,
      "date" : DateTime.now().toIso8601String()
    };
  }

  static List<ExerciseRating> setOfFromSnapshot(DataSnapshot snapshot) {

    List<ExerciseRating> ratings = new List<ExerciseRating>();

    Map<dynamic, dynamic> values = snapshot.value;

    values.forEach((key, values) {
      ratings.add(ExerciseRating.fromMap(values));
    });

    return ratings;
  }

  String getRating() {
    return rating;
  }

  String getType() {
    return type;
  }

  String getDuration() {
    return duration;
  }

  DateTime getDate() {
    return date;
  }

}