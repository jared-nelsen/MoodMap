
import 'package:firebase_database/firebase_database.dart';

class Emotion {

  String _key;

  String _emotion;

  Emotion(this._emotion);

  Emotion.fromSnapshot(DataSnapshot snapshot) :
      _key = snapshot.key,
      _emotion = snapshot.value["emotion"];

  toJson() {
    return {
      "emotion" : _emotion
    };
  }

}