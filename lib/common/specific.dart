
import 'package:firebase_database/firebase_database.dart';

class SpecificsItem {

  String key;

  String _specific;

  SpecificsItem(this._specific);

  SpecificsItem.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        _specific = snapshot.value["specific"];

  toJson() {
    return {
      "specific" : _specific,
    };
  }

  String getSpecific() {
    return _specific;
  }

}