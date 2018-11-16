
import 'package:firebase_database/firebase_database.dart';

class JournalEntry {

  String _key;

  String _date = "";
  String _circumstances = "";
  String _description = "";
  String _externalHappenings = "";
  String _internalHappenings = "";
  String _reflectionsAndCorrections = "";
  String _moodPassing = "";

  JournalEntry(){
    setDate(DateTime.now());
  }

  JournalEntry.fromSnapshot(DataSnapshot snapshot) :
      _key = snapshot.key,
      _date = snapshot.value["date"],
      _circumstances = snapshot.value["circumstances"],
      _description = snapshot.value["description"],
      _externalHappenings = snapshot.value["external_happenings"],
      _internalHappenings = snapshot.value["internal_happenings"],
      _reflectionsAndCorrections = snapshot.value["reflections_and_corrections"],
      _moodPassing = snapshot.value["abatement"];

  toJson() {
    return {
      "date" : _date,
      "circumstances" : _circumstances,
      "description" : _description,
      "external_happenings" : _externalHappenings,
      "internal_happenings" : _internalHappenings,
      "reflections_and_corrections" : _reflectionsAndCorrections,
      "abatement" : _moodPassing,
    };
  }

  String getDate() {
    return _date;
  }

  String getKey() {
    return _key;
  }

  String getCircumstances() {
    return _circumstances;
  }

  String getDescription() {
    return _description;
  }

  String getExternalHappenings() {
    return _externalHappenings;
  }

  String getInternalHappenings() {
    return _internalHappenings;
  }

  String getReflectionsAndCorrections() {
    return _reflectionsAndCorrections;
  }

  String getMoodPassing() {
    return _moodPassing;
  }

  void setDate(DateTime date) {

    StringBuffer s = new StringBuffer();

    s.write(date.month);
    s.write("/");
    s.write(date.day);
    s.write("/");
    s.write(date.year);

    this._date = s.toString();
  }

  void setCircumstances(String circumstances) {
    this._circumstances = circumstances;
  }

  void setDescription(String description) {
    this._description = description;
  }

  void setExternalHappenings(String externalHappenings) {
    this._externalHappenings = externalHappenings;
  }

  void setInternalHappenings(String internalHappenings) {
    this._internalHappenings = internalHappenings;
  }

  void setReflectionsAndCorrections(String reflectionsAndCorrections) {
    this._reflectionsAndCorrections = reflectionsAndCorrections;
  }

  void setAbatement(String abatement) {
    this._moodPassing = abatement;
  }

}