
import 'package:flutter/material.dart';

class MedicationListItem extends StatefulWidget {

  String _medicationName;
  String _dosage;
  String _startDate;

  MedicationListItem(this._medicationName, this._dosage, this._startDate);

  @override
  State<StatefulWidget> createState() => new MedicationListItemState(this._medicationName, this._dosage, this._startDate);

}

class MedicationListItemState extends State<MedicationListItem> {

  String _medicationName;
  String _dosage;
  String _startDate;

  MedicationListItemState(this._medicationName, this._dosage, this._startDate);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(buildInfo(), style: new TextStyle(fontSize: 16.0),),
      trailing: new FlatButton(onPressed: null, child: new Icon(Icons.cancel)),
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