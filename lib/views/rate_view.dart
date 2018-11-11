import 'package:flutter/material.dart';

import 'package:mood_map/emotions/categories_rate.dart';
import 'package:mood_map/emotions/specifics_rate.dart';
import 'package:mood_map/emotions/emotions_rate.dart';
import 'package:mood_map/emotions/emotions_quick_rate.dart';

import 'package:mood_map/application/emotion_context.dart';

class RateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RateViewState();

}

class RateViewState extends State<RateView> {

  static EmotionContext _emotionContext = new EmotionContext(navigateToCategories,
                                                             navigateToSpecifics,
                                                             navigateToEmotions,
                                                             navigateToQuickRate);

  static PageController _pageController;

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[

          new RateCategoriesView(_emotionContext),
          new RateSpecificsView(_emotionContext),
          new RateEmotionsView(_emotionContext),
          new EmotionsQuickRateView(_emotionContext)

        ],
      ),

    );
  }

  static void _navigateToPage(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  static void navigateToCategories() {
    _navigateToPage(0);
  }

  static void navigateToSpecifics() {
    _navigateToPage(1);
  }

  static void navigateToEmotions() {
    _navigateToPage(2);
  }

  static void navigateToQuickRate() {
    _navigateToPage(3);
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}
