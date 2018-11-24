
import 'package:flutter/material.dart';

class TurnstyleItem extends StatefulWidget {

  _TurnstyleItemState _state;

  String _itemText;
  Function _tappedCallback;

  TurnstyleItem(this._itemText, this._tappedCallback);

  @override
  State<StatefulWidget> createState() => _createState(_itemText, _tappedCallback);

  _TurnstyleItemState _createState(String _itemText, Function _tappedCallback) {

    _state = new _TurnstyleItemState(_itemText, _tappedCallback);

    return _state;
  }

  void setSelected(bool selected) {
    _state.setSelected(selected);
  }

  String getText() {
    return _itemText;
  }

}

class _TurnstyleItemState extends State<TurnstyleItem> {

  String _textString;

  Text _text;
  FontWeight _weight = FontWeight.normal;
  Color _textColor = Colors.black;
  TextDecoration _textDecoration = TextDecoration.none;
  Color _backgroundColor = Colors.white;

  Function _tappedCallback;

  _TurnstyleItemState(String text, Function tappedCallback) {

    _textString = text;
    _text = new Text(text, style: new TextStyle(fontWeight: _weight, color: _textColor, decoration: _textDecoration, fontSize: 18.0),);
    _tappedCallback = tappedCallback;

  }

  @override
  Widget build(BuildContext context) {

    return new InkWell(

      child: new Container(

        color: _backgroundColor,

        margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),

        child: _text,

      ),

      onTap: () {
        setSelected(true);
        Function.apply(_tappedCallback(_textString), null);
      },
    );

  }

  String getText() {
    return _textString;
  }

  void setSelected(bool selected) {

    setState(() {

      if(selected) {
        _weight = FontWeight.bold;
        _textColor = Colors.green;
        _textDecoration = TextDecoration.underline;
        _backgroundColor = Colors.green;
      } else {
        _weight = FontWeight.normal;
        _textColor = Colors.black.withOpacity(10.0);
        _textDecoration = TextDecoration.none;
        _backgroundColor = Colors.white;
      }

    });

  }

}