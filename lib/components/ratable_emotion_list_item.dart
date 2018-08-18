
import 'package:flutter/material.dart';

class RatableEmotionListItem extends StatefulWidget {

  String dbKey;

  String category;
  String specific;
  String emotion;

  String _rating = "0";

  RatableEmotionListItem({this.dbKey, this.category, this.specific, this.emotion});

  @override
  State<StatefulWidget> createState() => new RatableEmotionListItemState(this.emotion);

  _setRating(String rating) {
    this._rating = rating;
  }

  String getDBKey() {
    return dbKey;
  }

  String getCategory() {
    return category;
  }

  String getSpecific() {
    return specific;
  }

  String getEmotion() {
    return emotion;
  }

  String getRating() {
    return _rating;
  }

}

typedef void SetRating(String value);

class RatableEmotionListItemState extends State<RatableEmotionListItem> {
  SetRating ratingSetter;

  String _title;

  var _ratings = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  RatableEmotionListItemState(this._title);

  String _rating = '0';

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Text(_title),
      trailing: new DropdownButton<String>(

          items: _ratings.map((String rating) {
            return new DropdownMenuItem<String>(value: rating, child: new Text(rating));}).toList(),

        value: _rating,

        onChanged: (String value) {
            setState(() {
              _rating = value;
            });
            widget._setRating(_rating);
        },

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