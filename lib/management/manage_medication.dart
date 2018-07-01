
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mood_map/components/medication_list_item.dart';
import 'package:mood_map/common/medication.dart';

import 'package:firebase_database/firebase_database.dart';

class ManageMedicationView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new ManageMedicationViewState();

}

class ManageMedicationViewState extends State<ManageMedicationView> {

  final firebaseRef = FirebaseDatabase.instance.reference().child("medications");

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  List<MedicationListItem> _medications = new List();

  String _medicationToAdd;
  String _dosageToAdd;
  String _dateStartedToAdd = _formatDate(new DateTime.now());

  ManageMedicationViewState() {
    firebaseRef.onChildAdded.listen(_addMedicationToList);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new ListView(
        children: _medications.map((MedicationListItem item){
          return item;
        }).toList(),
      ),

      floatingActionButton: new FloatingActionButton(
        onPressed: _addMedication,
        child: new Icon(Icons.add),
      ),

    );

  }

  Future<Null> _addMedication() async {

    await showDialog(

        context: context,

        child: new Form(
          key: _formKey,
          child: new SimpleDialog(

            title: new Text("Add a medication"),

            children: <Widget>[

              new Padding(

                padding: const EdgeInsets.all(10.0),

                child: new TextFormField(

                  decoration: new InputDecoration(

                      hintText: "Medication Name",

                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
                          borderSide: new BorderSide(color: Colors.black, width: 1.0)
                      )

                  ),

                  autofocus: true,

                  validator: (value){

                    _medicationToAdd = value;

                    if(value.isEmpty || value == null) {
                      return "Please enter a medication name";
                    }
                  },
                ),

              ),


              new Padding(

                padding: const EdgeInsets.all(10.0),

                child: new TextFormField(

                  decoration: new InputDecoration(

                      hintText: "Dosage: eg. 20 mg",

                      border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
                          borderSide: new BorderSide(color: Colors.black, width: 1.0)
                      )

                  ),

                  validator: (value){

                    _dosageToAdd = value;

                    if(value.isEmpty || value == null) {
                      return "Please enter a dosage";
                    }
                  },

                ),
              ),

              new Padding(

                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),

                child: new Row(

                  children: <Widget>[

                    new Expanded(

                      child: new Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                            child: new Text("Start Date: $_dateStartedToAdd", style: new TextStyle(fontSize: 17.0),),
                          )
                        ],

                      ),
                    ),

                    new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                          child: new IconButton(
                              icon: new Icon(Icons.date_range),
                              iconSize: 40.0,
                              onPressed: (){_selectStartDate(context);}),
                        )
                      ],

                    )

                  ],
                ),

              ),

              new Row(

                children: <Widget>[
                  new Expanded(

                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        new FlatButton(
                            child: new Text("Add", style: new TextStyle(color: Colors.green,),),
                            onPressed: () {
                              if(_formKey.currentState.validate()) {
                                _addMedicationToDatabase(_medicationToAdd, _dosageToAdd, _dateStartedToAdd);
                              }
                            }
                        )
                      ],

                    ),

                  ),

                  new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      new FlatButton(

                          child: new Text("Cancel"),

                          onPressed: () {
                            setState(() {
                              Navigator.pop(context, null);
                            });})

                    ],
                  )
                ],
              )

            ],

          ),
        ),

    );
  }

  void _addMedicationToDatabase(String name, String dosage, String startDate) {

    setState(() {

      Medication medication = new Medication(name, dosage, startDate);

      var ref = FirebaseDatabase.instance.reference().child("medications").push();

      ref.set(medication.toJson());

      Navigator.pop(context, null);
    });

  }

  void _addMedicationToList(Event event) {

    setState(() {

      Medication newMedication = Medication.fromSnapshot(event.snapshot);

      bool alreadyThere = false;
      for(var medication in _medications) {
        if(medication.dbKey == newMedication.key) {
          alreadyThere = true;
          break;
        }
      }

      if(!alreadyThere){
        _medications.add(new MedicationListItem(newMedication.key, newMedication.medicationName, newMedication.dosage, newMedication.startDate, _removeMedication));
      }

    });
  }

  void _removeMedication(String medicationName) async {

    await showDialog(context: context,
      builder: (BuildContext context) {

        return new SimpleDialog(
          title: new Text("Are you sure you would like to remove this medication?"),
          children: <Widget>[

            new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new SimpleDialogOption(
                      child: const Text("Yes"),
                      onPressed: (){

                        //Make server call to remove medication here

                        setState(() {
                          int index = 0;
                          for(int i = 0; i < _medications.length; i++) {
                            MedicationListItem item = _medications.elementAt(i);
                            if(medicationName == item.getName()) {
                              index = i;
                              break;
                            }
                          }

                          _medications.removeAt(index);
                        });

                        Navigator.pop(context);
                      },
                    ),
                    new SimpleDialogOption(
                      child: const Text("No"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )

          ],
        );
      }
    );

  }

  Future<Null> _selectStartDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2000, 1),
        lastDate: new DateTime(3000)
    );

    if(picked != null) {
      setState(() {
        _dateStartedToAdd = _formatDate(picked);
      });
    }

  }

  static String _formatDate(DateTime time) {
    StringBuffer b = new StringBuffer();

    b.write(time.month);
    b.write("/");
    b.write(time.day);
    b.write("/");
    b.write(time.year);

    return b.toString();
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
