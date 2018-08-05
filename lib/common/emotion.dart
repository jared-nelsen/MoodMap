
import 'package:firebase_database/firebase_database.dart';

class Emotion {

  String _dbkey;

  String _category;
  String _specifics;
  String _emotion;

  Emotion(this._category, this._specifics, this._emotion);

  Emotion.fromSnapshot(DataSnapshot snapshot) :
      _dbkey = snapshot.key,
      _category = snapshot.value["category"],
      _specifics = snapshot.value["specifics"],
      _emotion = snapshot.value["emotion"];

  toJson() {
    return {
      "category" : _category,
      "specifics" : _specifics,
      "emotion" : _emotion
    };
  }

  String getDBKey() {
    return _dbkey;
  }

  String getCategory() {
    return _category;
  }

  String getSpecific() {
    return _specifics;
  }

  String getEmotion() {
    return _emotion;
  }

}