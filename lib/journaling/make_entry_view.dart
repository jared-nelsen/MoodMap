
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:mood_map/components/ensure_visible_when_focused.dart';

import 'package:mood_map/common/journal_entry.dart';

import 'package:firebase_database/firebase_database.dart';

class MakeEntryView extends StatefulWidget {

  final Function _journalEntryFunction;

  MakeEntryView(this._journalEntryFunction);

  @override
  State<StatefulWidget> createState() => new MakeEntryState(_journalEntryFunction);

}

class MakeEntryState extends State<MakeEntryView> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode _focusNodeCircumstances = new FocusNode();
  FocusNode _focusNodeDescription = new FocusNode();
  FocusNode _focusNodeExternalHappenings = new FocusNode();
  FocusNode _focusNodeInternalHappenings = new FocusNode();
  FocusNode _focusNodeReflectionsAndCorrections = new FocusNode();
  FocusNode _focusNodeAbatement = new FocusNode();

  Function _journalEntryFunction;

  JournalEntry _journalEntry = new JournalEntry();

  MakeEntryState(this._journalEntryFunction);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

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

    return new EnsureVisibleWhenFocused(
      focusNode: _focusNodeCircumstances,
      child: new TextFormField(

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

          _journalEntry.setCircumstances(value);

          if(value.isEmpty || value == null) {
            return "Please enter some circumstances.";
          }

        },

        focusNode: _focusNodeCircumstances,

      ),
    );

  }

  Widget description() {

    return new EnsureVisibleWhenFocused(
      focusNode: _focusNodeDescription,
      child: new TextFormField(

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

          _journalEntry.setDescription(value);

          if(value.isEmpty || value == null) {
            return "Please enter a description.";
          }

        },

        focusNode: _focusNodeDescription,

      ),
    );

  }

  Widget externalHappenings() {

    return new EnsureVisibleWhenFocused(
      focusNode: _focusNodeExternalHappenings,
      child: new TextFormField(

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

          _journalEntry.setExternalHappenings(value);

          if(value.isEmpty || value == null) {
            return "Please enter some external happenings.";
          }

        },

        focusNode: _focusNodeExternalHappenings,

      ),
    );

  }

  Widget internalHappenings() {

    return new EnsureVisibleWhenFocused(
      focusNode: _focusNodeInternalHappenings,
      child: new TextFormField(

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

          _journalEntry.setInternalHappenings(value);

          if(value.isEmpty || value == null) {
            return "Please enter some internal happenings.";
          }

        },

        focusNode: _focusNodeInternalHappenings,

      ),
    );

  }

  Widget reflectionsAndCorrections() {

    return EnsureVisibleWhenFocused(
      focusNode: _focusNodeReflectionsAndCorrections,
      child: new TextFormField(

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

          _journalEntry.setReflectionsAndCorrections(value);

          if(value.isEmpty || value == null) {
            return "Please enter some reflections.";
          }

        },

        focusNode: _focusNodeReflectionsAndCorrections,

      ),
    );

  }

  Widget abatement() {
    return EnsureVisibleWhenFocused(
      focusNode: _focusNodeAbatement,
      child: new TextFormField(

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

          _journalEntry.setAbatement(value);

          if(value.isEmpty || value == null) {
            return "Please enter an abatement.";
          }

        },

        focusNode: _focusNodeAbatement,

      ),
    );
  }

  Widget footerButtons() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        new Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 9.0, 0.0),
          child: new RaisedButton(onPressed: _saveEntry, textColor: Colors.green ,child: new Text("Save Entry")) ,),

        new RaisedButton(onPressed: _cancel, child: new Text("Cancel"))

      ],
    );
  }

  Widget divider() {
    return const SizedBox(height: 24.0);
  }

  void _saveEntry() {

    if(_formKey.currentState.validate()) {

      var ref = FirebaseDatabase.instance.reference().child("journal_entries").push();

      ref.set(_journalEntry.toJson());

      Function.apply(_journalEntryFunction, null);
    }

  }

  void _cancel() {

    _formKey.currentState.reset();
    Function.apply(_journalEntryFunction, null);

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


