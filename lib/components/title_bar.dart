
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {

  String _title;

  TitleBar(this._title);

  @override
  Widget build(BuildContext context) {

    return new Container(

      color: Colors.blueAccent,

      child: new Row(

        children: <Widget>[

          new Expanded(

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                new Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(_title,
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                )

              ],
            )

          )

        ],
      ),
    );

  }

  void setTitle(String title) {
    this._title = title;
  }

}