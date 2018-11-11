
import 'package:quiver/collection.dart';

import 'package:mood_map/utilities/database.dart';

import 'package:mood_map/common/category.dart';
import 'package:mood_map/common/specific.dart';
import 'package:mood_map/common/emotion.dart';

class FirstTimeDataUploader {

  List<String> _categories = [ "Work", "Home", "School", "Relationships"];

  List<String> _specifics = [ "My Boss ", "Work Tasks", "Coworkers", "My Mom", "My Dad", "My children", "My friends", "", "", ""];

  Multimap _categoriesToSpecifics = new Multimap();

  List<String> _emotions = [ "Happiness", "Anger", "Sadness", "Rage", "Doubtful", "Joyful", "Anxious", "Loneliness", "Depression", "Delight", "Frustrated",
                             "Resentful", "Pitiful", "Small", "Elation", "Victorious", "Controlled", "Fast", "Friendly", "Unintelligent", "Capable", "Weak",
                             "Bullied", "Uncool", "Thankful", "Out of Control", "Useless"];



  FirstTimeDataUploader() {
    _initializeData();
  }

  void _initializeData() {

    _initializeEmotions();
    _initializeCategories();
    _initializeSpecifics();
    _initializeContextualizedEmotions();

  }

  void _initializeEmotions() {

    var ref = Database.emotionsPushReference();

    for(String emotion in _emotions) {
      Emotion emotionData = new Emotion("General", "General", emotion);
      ref.set(emotionData.toJson());
    }

  }

  void _initializeCategories() {

    var ref = Database.categoriesPushReference();

  }

  void _initializeSpecifics() {

    var ref = Database.specificsPushReference();

  }

  void _initializeContextualizedEmotions() {

    var ref = Database.emotionsPushReference();



  }

}