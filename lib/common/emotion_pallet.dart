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

      body: new ListView(
        children: _emotions.map((EmotionListItem item) {
          return item;
        }).toList(),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: addEmotion,
        child: new Icon(Icons.add),),

    );
  }

  void addEmotion() {
    setState(() {
      _emotions.add(new EmotionListItem("Emotion"));
    });
  }

  List<String> getSelectedTitles() {
    List<String> selected = new List();
    
    for(EmotionListItem e in _emotions) {
      if(e.isSelected()) {
        selected.add(e.getTitle());
      }
    }
    
    return selected;
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
