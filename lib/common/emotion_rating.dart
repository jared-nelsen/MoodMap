
import 'package:firebase_database/firebase_database.dart';

class EmotionRating {

  String key;

  String emotion;
  int rating;

  EmotionRating(this.emotion, this.rating);

  EmotionRating.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      emotion = snapshot.value["emotion"],
      rating = snapshot.value["rating"];

  toJson() {
    return {
      "emotion" : emotion,
      "rating" : rating
    };
  }

}