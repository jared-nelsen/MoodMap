
import 'package:flutter/material.dart';

class RatableEmotionListItem extends StatefulWidget {

  String _dbKey;

  String _emotion;
  RatingWrapper _rating = new RatingWrapper();

  RatableEmotionListItem(this._dbKey, this._emotion);

  @override
  State<StatefulWidget> createState() => new RatableEmotionListItemState(this._emotion, this._rating);

  String getDBKey() {
    return _dbKey;
  }

  String getEmotionName() {
    return _emotion;
  }

  String getRating() {
    _rating.getRating();
  }

}

class RatableEmotionListItemState extends State<RatableEmotionListItem> {

  String _title;

  var _ratings = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  RatableEmotionListItemState(this._title, this._ratingWrapper);

  String _rating = '0';

  RatingWrapper _ratingWrapper;

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
              _ratingWrapper.setRating(_rating);
            });
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

class RatingWrapper{

  String _rating;

  void setRating(String rating) {
    _rating = rating;
  }

  String getRating() {
    return _rating;
  }

}