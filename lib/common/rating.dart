
import 'package:firebase_database/firebase_database.dart';

class Rating {

  String _key;

  String rating;

  Rating(this.rating);

  Rating.fromSnapshot(DataSnapshot snapshot) :
        _key = snapshot.key,
        rating = snapshot.value["rating"];

  toJson() {
    return {
      "rating" : rating
    };
  }

}