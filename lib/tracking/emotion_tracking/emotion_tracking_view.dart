
import 'package:flutter/material.dart';

import 'package:mood_map/tracking/emotion_tracking/emotion_tracking_components/categories_turnstyle_selector.dart';
import 'package:mood_map/tracking/emotion_tracking/emotion_tracking_components/specifics_turnstyle_selector.dart';

import 'package:mood_map/application/emotion_context.dart';

class EmotionTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _EmotionTrackingViewState();

}

class _EmotionTrackingViewState extends State<EmotionTrackingView> {
  
  static EmotionContext _emotionContext = new EmotionContext();

  static CategoryTurnstyleSelector _categoryTurnstyle = new CategoryTurnstyleSelector(_emotionContext, _newCategorySelected);
  static SpecificsTurnstyleSelector _specificsTurnstyle = new SpecificsTurnstyleSelector(_emotionContext, _newSpecificsSelected);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new Container(
        
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: new Column(

          children: <Widget>[
            _buildInfoBar("Category"),
            _divider(),
            _categoryTurnstyle,
            _divider(),
            _buildInfoBar("Specifics"),
            _divider(),
            _specificsTurnstyle,
            _divider(),
          ],

        ),
      )
    );

  }

  Widget _buildInfoBar(String info) {

    return new Column(
      children: <Widget>[

        new Row(
          mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              new Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: new Text(info, style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),)
              )

            ],
        )
      ],
    );
  }

  static void _newCategorySelected(String category) {
    _emotionContext.setCategory(category);
    _specificsTurnstyle.reloadSpecifics();
  }

  static void _newSpecificsSelected(String specific) {
    _emotionContext.setSpecific(specific);

  }

  Widget _divider() {
    return new Divider(
      color: Colors.black,
      height: 0.0,
      indent: 0.0,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

}