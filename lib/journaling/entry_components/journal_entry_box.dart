
import 'package:flutter/material.dart';


class JournalEntryBox extends StatefulWidget {

  String _title;
  String _hint;
  Size _size;

  JournalEntryBox(this._title, this._hint, this._size);

  @override
  State<StatefulWidget> createState() => new EntryBoxState(_title, _hint, _size);

}

class EntryBoxState extends State<JournalEntryBox> {

  String _title;
  String _hint;
  Size _size;

  EntryBoxState(this._title, this._hint, this._size);

  @override
  Widget build(BuildContext context) {
    return new Container(

      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          new Container(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: new Text(_title,
                    style: new TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                   )),
          ),

          new Container (
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),

            child: new TextField(
              autocorrect: true,
              autofocus: true,
              decoration: new InputDecoration(
                hintText: _hint,
                border: OutlineInputBorder(

                )
              ),
            ),

          )

        ],
      ),
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