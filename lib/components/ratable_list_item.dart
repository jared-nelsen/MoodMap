
import 'package:flutter/material.dart';

class RatableListItem extends StatefulWidget {

  String _title;

  RatableListItem(this._title);

  @override
  State<StatefulWidget> createState() => new RatableListItemState(this._title);

}

class RatableListItemState extends State<RatableListItem> {

  String _title;

  var _ratings = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  RatableListItemState(this._title);

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