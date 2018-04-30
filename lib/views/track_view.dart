
import 'package:flutter/material.dart';

import 'package:mood_map/common/emotion_pallet.dart';

class TrackView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new TrackViewState();

}

class TrackViewState extends State<TrackView> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new EmotionPallet(),
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
