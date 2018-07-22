import 'package:flutter/material.dart';

import 'package:mood_map/emotions/categories_rate.dart';
import 'package:mood_map/emotions/specifics_rate.dart';
import 'package:mood_map/emotions/emotions_rate.dart';

import 'package:mood_map/components/emotion_context.dart';

class RateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RateViewState();

}

class RateViewState extends State<RateView> {

  static EmotionContext _emotionContext = new EmotionContext(animateToSpecifics, animateToEmotions);

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
          new RateEmotionsView(animateToCategories, animateToSpecifics)

        ],
      ),

    );
  }

  static void _animateToPage(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  static void animateToCategories() {
    _animateToPage(0);
  }

  static void animateToSpecifics() {
    _animateToPage(1);
  }

  static void animateToEmotions() {
    _animateToPage(2);
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
