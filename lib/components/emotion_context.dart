
import 'package:mood_map/components/ratable_list_item.dart';

import 'package:firebase_database/firebase_database.dart';

class EmotionContext {

  final String _baseRecords = "emotion_ratings";
  final String _categoryRecords = "categories";
  final String _specificsRecords = "specifics";

  String _category;
  String _specific;

  Function navigateSpecifics;
  Function navigateEmotions;

  EmotionContext(this.navigateSpecifics, this.navigateEmotions);

  String getCategory() {
    return _category;
  }

  String getSpecifics() {
    return _specific;
  }

  void setAndNavigateCategory(String category) {
    _category = category;
    Function.apply(navigateSpecifics, null);
  }

  void setAndNavigateSpecific(String specifics) {
    _specific = specifics;
    Function.apply(navigateEmotions, null);
  }

  void saveEmotionContext(List<RatableListItem> emotions) {

    if(_category == null || _specific == null) {
      return;
    }

    var db = FirebaseDatabase.instance.reference()
        .child(_baseRecords)
        .child(_categoryRecords)
        .child(_category)
        .child(_specificsRecords)
        .child(_specific);

    for(RatableListItem emotion in emotions) {

      var ref = db.child(emotion.getTitle()).push();

      ref.set( {"rating": emotion.getRating()} );

    }

  }

}