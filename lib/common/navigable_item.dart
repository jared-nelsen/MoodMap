
import 'package:firebase_database/firebase_database.dart';

class CategoryItem {

  String key;

  String category;

  CategoryItem(this.category);

  CategoryItem.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
      category = snapshot.value["category"];

  toJson() {
    return {
      "category" : category,
    };
  }

}