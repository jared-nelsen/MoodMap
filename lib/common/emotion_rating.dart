
import 'package:firebase_database/firebase_database.dart';

class EmotionRating {

  String _dbKey;

  String _category;
  String _specifics;
  String _emotion;

  DateTime dateTime;

  String _rating;

  EmotionRating(this._dbKey, this._category, this._specifics, this._emotion, this._rating, {this.dateTime});

  EmotionRating.fromSnapshot(DataSnapshot snapshot) :
      _dbKey = snapshot.key,
      _category = snapshot.value["category"],
      _specifics = snapshot.value["specifics"],
      _emotion = snapshot.value["emotion"],
      _rating = snapshot.value["rating"],
      dateTime = DateTime.parse(snapshot.value["date_time"]);

  toJson() {
    return {
      "category" : _category,
      "specifics" : _specifics,
      "emotion" : _emotion,
      "rating" : _rating,
      "date_time": DateTime.now().toIso8601String()
    };
  }

  String getDbKey() {
    return _dbKey;
  }

  String getContext() {
    return _category;
  }

  String getCategory() {
    return _category;
  }

  String getSpecifics() {
    return _specifics;
  }

  String getEmotion() {
    return _emotion;
  }

  String getRating() {
    return _rating;
  }

}