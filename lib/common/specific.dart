
import 'package:firebase_database/firebase_database.dart';

class SpecificsItem {

  String key;

  String _category;
  String _specific;

  SpecificsItem(this._category, this._specific);

  SpecificsItem.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        _category = snapshot.value["category"],
        _specific = snapshot.value["specific"];

  toJson() {
    return {
      "category" : _category,
      "specific" : _specific,
    };
  }

  String getCategory() {
    return _category;
  }

  String getSpecific() {
    return _specific;
  }

}