import 'package:flutter/material.dart';

import 'package:mood_map/emotions/categories_rate.dart';
import 'package:mood_map/emotions/specifics_rate.dart';
import 'package:mood_map/emotions/emotions_rate.dart';

class RateView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RateViewState();

}

class RateViewState extends State<RateView> {

  PageController _pageController;
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[

          new RateCategoriesView(animateToSpecifics),
          new RateSpecificsView(animateToCategories, animateToEmotions),
          new RateEmotionsView(animateToCategories, animateToSpecifics)

        ],
      ),

    );
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  void animateToCategories() {
    _animateToPage(0);
  }

  void animateToSpecifics() {
    _animateToPage(1);
  }

  void animateToEmotions() {
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
