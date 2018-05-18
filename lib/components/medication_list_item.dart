
import 'package:flutter/material.dart';

class MedicationListItem extends StatefulWidget {

  String _medicationName;
  String _dosage;
  String _startDate;
  Function _removeCallback;

  MedicationListItem(this._medicationName, this._dosage, this._startDate, this._removeCallback);

  @override
  State<StatefulWidget> createState() => new MedicationListItemState(this._medicationName, this._dosage, this._startDate, this._removeCallback);

  String getName() {
    return _medicationName;
  }

}

class MedicationListItemState extends State<MedicationListItem> {

  String _medicationName;
  String _dosage;
  String _startDate;

  Function _removeCallback;

  MedicationListItemState(this._medicationName, this._dosage, this._startDate, this._removeCallback);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(buildInfo(), style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(onPressed: () {_removeCallback(_medicationName);}, child: new Icon(Icons.cancel)),
    );
  }

  String buildInfo() {

    StringBuffer buffer = new StringBuffer();

    buffer.write(_medicationName);
    buffer.write(" ");
    buffer.write(_dosage);
    buffer.write(" ");
    buffer.write(_startDate);

    return buffer.toString();
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