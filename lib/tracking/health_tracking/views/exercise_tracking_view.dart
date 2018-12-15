
import 'package:flutter/material.dart';

class ExerciseTrackingView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _ExerciseTrackingViewState();

}

class _ExerciseTrackingViewState extends State<ExerciseTrackingView> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[

          ],
        )
      )
          
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