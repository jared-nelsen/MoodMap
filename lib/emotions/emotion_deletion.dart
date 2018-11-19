
import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/category.dart';
import 'package:mood_map/common/specific.dart';
import 'package:mood_map/common/emotion.dart';
import 'package:mood_map/common/emotion_rating.dart';


class EmotionDeletionModule {

  static void deleteCategory(String categoryName) {

    //First we must remove the category item from the database
    Database.categoriesReference().onChildAdded.forEach((categoryEvent) {
      
      CategoryItem category = CategoryItem.fromSnapshot(categoryEvent.snapshot);
      
      if(category.getCategory() == categoryName) {
        Database.categoriesReference().child(category.getDbKey()).remove();
      }
      
    });

    //Then we must remove the specifics associated with this category from the database
    Database.specificsReference().onChildAdded.forEach((specificsEvent) {

      SpecificsItem specifics = SpecificsItem.fromSnapshot(specificsEvent.snapshot);

      if(specifics.getCategory() == categoryName) {
        Database.specificsReference().child(specifics.getDbKey()).remove();
      }

    });

    //Next we must remove all emotions associated with this category from the database
    Database.emotionsReference().onChildAdded.forEach((emotionEvent) {

      Emotion emotion = Emotion.fromSnapshot(emotionEvent.snapshot);

      if(emotion.getCategory() == categoryName) {
        Database.emotionsReference().child(emotion.getDbKey()).remove();
      }

    });

    //Finally we must remove all associated emotion rating data from the database
    Database.emotionRatingReference().onChildAdded.forEach((emotionRatingEvent) {

      EmotionRating rating = EmotionRating.fromSnapshot(emotionRatingEvent.snapshot);

      if(rating.getCategory() == categoryName) {
        Database.emotionRatingReference().child(rating.getDbKey()).remove();
      }

    });
    
  }
  
  static void deleteSpecific(String specificName) {

    //First we must remove the specifics record associated with this specifics name
    Database.specificsReference().onChildAdded.forEach((specificsEvent) {

      SpecificsItem specifics = SpecificsItem.fromSnapshot(specificsEvent.snapshot);

      if(specifics.getSpecific() == specificName) {
        Database.specificsReference().child(specifics.getDbKey()).remove();
      }

    });

    //Next we must remove all emotions associate with this specific
    Database.emotionsReference().onChildAdded.forEach((emotionsEvent) {

      Emotion emotion = Emotion.fromSnapshot(emotionsEvent.snapshot);

      if(emotion.getSpecific() == specificName) {
        Database.emotionsReference().child(emotion.getDbKey()).remove();
      }

    });

    //Finally we must remove all emotion ratings associated with this specific
    Database.emotionRatingReference().onChildAdded.forEach((emotionRatingEvent) {

      EmotionRating rating = EmotionRating.fromSnapshot(emotionRatingEvent.snapshot);

      if(rating.getSpecifics() == specificName) {
        Database.emotionRatingReference().child(rating.getDbKey()).remove();
      }

    });

  }

  static void deleteEmotion(String emotionName) {

    //First we must remove the emotion item from the database
    Database.emotionsReference().onChildAdded.forEach((emotionEvent) {

      Emotion emotion = new Emotion.fromSnapshot(emotionEvent.snapshot);

      if(emotion.getEmotion() == emotionName) {
        Database.emotionsReference().child(emotion.getDbKey()).remove();
      }

    });

    //Then we must remove all emotion rating data associated with the emotion
    Database.emotionRatingReference().onChildAdded.forEach((ratingEvent) {

      EmotionRating rating = EmotionRating.fromSnapshot(ratingEvent.snapshot);

      if(rating.getEmotion() == emotionName) {
        Database.emotionRatingReference().child(rating.getDbKey()).remove();
      }

    });

  }

}