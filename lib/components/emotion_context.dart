
import 'package:mood_map/components/ratable_list_item.dart';

import 'package:firebase_database/firebase_database.dart';

class EmotionContext {

  final String _record = "emotion_rating";

  String _category;
  String _specific;

  Function categoryNavigation;
  Function specificsNavigation;
  Function emotionNavigation;

  EmotionContext(this.categoryNavigation, this.specificsNavigation, this.emotionNavigation);

  void setAndNavigateCategory(String category) {
    _category = category;
    Function.apply(categoryNavigation, null);
  }

  void setAndNavigateSpecifics(String specifics) {
    _specific = specifics;
    Function.apply(specificsNavigation, null);
  }

  void navigateEmotions(String emotion) {
    Function.apply(emotionNavigation, null);
  }

  void saveEmotionContext(List<RatableListItem> emotions) {

    var db = FirebaseDatabase.instance.reference().child(_record).child(_category).child(_specific);

    for(RatableListItem emotion in emotions) {
//
//      var ref = db.child(emotion.getTitle()).push();
//
//      ref.set( {"rating": emotion.getRating()} );
    }

  }

}