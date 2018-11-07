
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

import 'package:mood_map/components/ensure_visible_when_focused.dart';

import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/journaling_context.dart';

import 'package:mood_map/utilities/database_manager.dart';

class MakeEntryView extends StatefulWidget {

  JournalingContext _journalingContext;

  MakeEntryView(this._journalingContext);

  @override
  State<StatefulWidget> createState() => new MakeEntryState(this._journalingContext);

}

class MakeEntryState extends State<MakeEntryView> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final TextEditingController _circumstancesController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _externalHappeningsController = new TextEditingController();
  final TextEditingController _internalHappeningsController = new TextEditingController();
  final TextEditingController _reflectionsAndCorrectionsController = new TextEditingController();
  final TextEditingController _abatementController = new TextEditingController();

  final int maxLines = 8;

  JournalingContext _journalingContext;

  JournalEntry _activeJournalEntry;

  MakeEntryState(this._journalingContext);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text("Make a Journal Entry")),

      body: new SafeArea(
          child: new Form(

              key: _formKey,

              child: new SingleChildScrollView(

                padding: const EdgeInsets.all(16.0),

                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[

                    circumstances(),
                    divider(),
                    description(),
                    divider(),
                    externalHappenings(),
                    divider(),
                    internalHappenings(),
                    divider(),
                    reflectionsAndCorrections(),
                    divider(),
                    abatement(),
                    divider(),
                    footerButtons()

                  ],

                ),

              )

          )
      ),

      resizeToAvoidBottomPadding: false,
    );

  }

  Widget circumstances() {

    return new TextFormField(

        controller: _circumstancesController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "Circumstances",
          hintText: "Who was there? Where were you?",
        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setCircumstances(value);

          if(value == null || value.isEmpty) {
            return "Please enter some circumstances.";
          }

        },

      );

  }

  Widget description() {

    return new TextFormField(

        controller: _descriptionController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "Description",
          hintText: "Describe your mood.",

        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setDescription(value);

          if(value == null || value.isEmpty) {
            return "Please enter a description.";
          }

        },

      );

  }

  Widget externalHappenings() {

    return new TextFormField(

        controller: _externalHappeningsController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "External Happenings",
          hintText: "What was happening around you?",

        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setExternalHappenings(value);

          if(value == null || value.isEmpty) {
            return "Please enter some external happenings.";
          }

        },

      );

  }

  Widget internalHappenings() {

    return new TextFormField(

        controller: _internalHappeningsController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "Internal Happenings",
          hintText: "What did it feel like inside?",

        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setInternalHappenings(value);

          if(value == null || value.isEmpty) {
            return "Please enter some internal happenings.";
          }

        },

      );

  }

  Widget reflectionsAndCorrections() {

    return new TextFormField(

        controller: _reflectionsAndCorrectionsController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "Reflections and Corrections",
          hintText: "Reflect on your mood. Did it make sense?",

        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setReflectionsAndCorrections(value);

          if(value == null || value.isEmpty) {
            return "Please enter some reflections.";
          }

        },

      );

  }

  Widget abatement() {

    return new TextFormField(

        controller: _abatementController,
        maxLines: maxLines,

        decoration: const InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(const Radius.circular(0.0)),
              borderSide: const BorderSide(color: Colors.black, width: 1.0)
          ),

          filled: true,

          labelText: "Abatement",
          hintText: "How and when did the mood pass?",

        ),

        autofocus: true,

        validator: (value) {

          _activeJournalEntry.setAbatement(value);

          if(value == null || value.isEmpty) {
            return "Please enter an abatement.";
          }

        },

      );

  }

  Widget footerButtons() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 9.0, 0.0),
          child: new RaisedButton(onPressed: _saveEntry, textColor: Colors.green ,child: new Text("Save Entry"))),

        new RaisedButton(onPressed: _cancel, child: new Text("Cancel"))

      ],
    );
  }

  Widget divider() {
    return const SizedBox(height: 24.0);
  }

  void _saveEntry() {

    if(_formKey.currentState.validate()) {

      var ref = DatabaseManager.journalEntriesPushReference();

      ref.set(_activeJournalEntry.toJson());

      _journalingContext.navigateToEntryListView();
    }

    clearFields();
  }

  void _cancel() {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: new Text("Discard your entry?"),
            children: <Widget>[

              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  new FlatButton(
                      child: new Text("Discard", style: new TextStyle(color: Colors.green),),
                      onPressed: (){

                        _formKey.currentState.reset();
                        clearFields();
                        Navigator.pop(context, null);
                        _journalingContext.navigateToEntryListView();

                      },

                  ),

                  new FlatButton(
                      child: new Text("No, Keep My Entry"),
                      onPressed: (){
                        Navigator.pop(context, null);
                      },
                  )

                ],
              )

            ],
          );
        }
    );

  }

  void loadJournalEntry() {
    _circumstancesController.text = _activeJournalEntry.getCircumstances();
    _descriptionController.text = _activeJournalEntry.getDescription();
    _externalHappeningsController.text = _activeJournalEntry.getExternalHappenings();
    _internalHappeningsController.text = _activeJournalEntry.getInternalHappenings();
    _reflectionsAndCorrectionsController.text = _activeJournalEntry.getReflectionsAndCorrections();
    _abatementController.text = _activeJournalEntry.getAbatement();
  }

  void clearFields() {
    _circumstancesController.text = "";
    _descriptionController.text = "";
    _externalHappeningsController.text = "";
    _internalHappeningsController.text = "";
    _reflectionsAndCorrectionsController.text = "";
    _abatementController.text = "";
  }

  @override
  void initState() {
    super.initState();

    _activeJournalEntry = _journalingContext.getCurrentJournalEntry();
    loadJournalEntry();

  }

  @override
  void dispose() {
    super.dispose();
  }

}


