
import 'package:firebase_database/firebase_database.dart';

class UserData {

  String _dbKey;

  String _uid;
  String _email;

  DateTime _createDate;

  UserData(this._uid, this._email, this._createDate);

  UserData.fromSnapshot(DataSnapshot snapshot) :
      _dbKey = snapshot.key,
      _uid = snapshot.value["uid"],
      _email = snapshot.value["email"],
      _createDate = DateTime.parse(snapshot.value["create_date"]);

  toJson() {
    return {
      "uid" : _uid,
      "email" : _email,
      "create_date" : _createDate.toIso8601String()
    };
  }

  String getDbKey() {
    return _dbKey;
  }

  String getUUID() {
    return _uid;
  }

  String getEmail() {
    return _email;
  }

  DateTime getCreateDate() {
    return _createDate;
  }

}