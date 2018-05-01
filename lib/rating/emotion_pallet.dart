import 'package:flutter/material.dart';

import 'package:mood_map/components/emotion_list_item.dart';

class EmotionPallet extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new EmotionPalletState();

}

class EmotionPalletState extends State<EmotionPallet> {

  List<EmotionListItem> _emotions = new List();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text("Emotion Pallet"),),

      body: new ListView(
        children: _emotions
      ),

      persistentFooterButtons: <Widget>[
        new FlatButton(onPressed: null, child: new Text("Add all")),
        new FlatButton(onPressed: null, child: new Text("Back"))
      ],

    );
  }

  void addEmotion(String emotionName) {
    final index = _emotions.length;
    final newList = new List<EmotionListItem>.from(_emotions)
      ..add(new EmotionListItem(
          title: emotionName,
          selected: true,
          onChange: (checked) => _listItemChange(index, checked),));

    setState(() {
      _emotions = newList;
    });
  }

  void _listItemChange(int listIndex, bool checked) {

    final newList = new List<EmotionListItem>.from(_emotions);
    EmotionListItem currentItem = _emotions[listIndex];

    newList[listIndex] = new EmotionListItem(
      title: currentItem.getTitle(),
      selected: checked,
      onChange: currentItem.onChanged(),
    );

    setState(() {
      _emotions = newList;
    });

  }

  List<String> getSelectedEmotions() {
    return _emotions.where((item) => item.isSelected()).map((item) => item.getTitle());
  }

  @override
  void initState() {
    super.initState();
    addEmotion("First");
    addEmotion("Second");
  }

  @override
  void dispose() {
    super.dispose();
  }

}
