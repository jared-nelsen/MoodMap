
import 'package:firebase_database/firebase_database.dart';

class Medication {

  String key;

  String medicationName;
  String dosage;
  String startDate;

  Medication(this.medicationName, this.dosage, this.startDate);

  Medication.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    medicationName = snapshot.value["name"],
    dosage = snapshot.value["dosage"],
    startDate = snapshot.value["start_date"];

  toJson() {
    return {
      "name" : medicationName,
      "dosage" : dosage,
      "start_date" : startDate
    };
  }


}