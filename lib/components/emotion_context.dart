
import 'package:mood_map/components/ratable_list_item.dart';

import 'package:firebase_database/firebase_database.dart';

class EmotionContext {

  final String _record = "emotion_rating";

  String _category;
  String _specific;

  Function navigateSpecifics;
  Function navigateEmotions;

  EmotionContext();

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

    var db = FirebaseDatabase.instance.reference().child(_record).child(_category).child(_specific);

    for(RatableListItem emotion in emotions) {

      var ref = db.child(emotion.getTitle()).push();

      ref.set( {"rating": emotion.getRating()} );

    }

  }

}