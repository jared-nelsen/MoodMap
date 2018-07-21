
import 'package:firebase_database/firebase_database.dart';

class SpecificsItem {

  String key;

  String specific;

  SpecificsItem(this.specific);

  SpecificsItem.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        specific = snapshot.value["specific"];

  toJson() {
    return {
      "specific" : specific,
    };
  }

}