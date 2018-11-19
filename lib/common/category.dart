
import 'package:firebase_database/firebase_database.dart';

class CategoryItem {

  String key;

  String _category;

  CategoryItem(this._category);

  CategoryItem.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      _category = snapshot.value["category"];

  toJson() {
    return {
      "category" : _category,
    };
  }

  String getDbKey() {
    return key;
  }

  String getCategory() {
    return _category;
  }

}