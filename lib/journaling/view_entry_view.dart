
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mood_map/common/journal_entry.dart';
import 'package:mood_map/components/ensure_visible_when_focused.dart';
import 'package:mood_map/components/journaling_context.dart';

class ViewEntryView extends StatefulWidget {

  JournalingContext _journalingContext;

  ViewEntryView(this._journalingContext);

  @override
  State<StatefulWidget> createState() => new ViewEntryViewState(this._journalingContext);

}

class ViewEntryViewState extends State<ViewEntryView> {

  final FocusNode _focusNodeCircumstances = new FocusNode();
  final FocusNode _focusNodeDescription = new FocusNode();
  final FocusNode _focusNodeExternalHappenings = new FocusNode();
  final FocusNode _focusNodeInternalHappenings = new FocusNode();
  final FocusNode _focusNodeReflectionsAndCorrections = new FocusNode();
  final FocusNode _focusNodeAbatement = new FocusNode();

  final TextEditingController _circumstancesController = new TextEditingController();
  final TextEditingController _descriptionController = new TextEditingController();
  final TextEditingController _externalHappeningsController = new TextEditingController();
  final TextEditingController _internalHappeningsController = new TextEditingController();
  final TextEditingController _reflectionsAndCorrectionsController = new TextEditingController();
  final TextEditingController _abatementController = new TextEditingController();

  final int _maxLines = 8;

  JournalingContext _journalingContext;

  JournalEntry _activeJournalEntry;

  ViewEntryViewState(this._journalingContext);

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      appBar: new AppBar(title: new Text("View Your Journal Entry")),

      body: new SafeArea(
          child: new Form(

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

        maxLines: _maxLines,

        controller: _circumstancesController,

        enabled: false,

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

        focusNode: _focusNodeCircumstances,

      );

  }

  Widget description() {

    return new TextFormField(

        maxLines: _maxLines,

        controller: _descriptionController,

        enabled: false,

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

        focusNode: _focusNodeDescription,

      );

  }

  Widget externalHappenings() {

    return new TextFormField(

        maxLines: _maxLines,

        controller: _externalHappeningsController,

        enabled: false,

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

        focusNode: _focusNodeExternalHappenings,

      );

  }

  Widget internalHappenings() {

    return new TextFormField(

        maxLines: _maxLines,

        controller: _internalHappeningsController,

        enabled: false,

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

        focusNode: _focusNodeInternalHappenings,

      );

  }

  Widget reflectionsAndCorrections() {

    return new TextFormField(

        maxLines: _maxLines,

        controller: _reflectionsAndCorrectionsController,

        enabled: false,

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

        focusNode: _focusNodeReflectionsAndCorrections,

      );

  }

  Widget abatement() {

    return new TextFormField(

        maxLines: _maxLines,

        controller: _abatementController,

        enabled: false,

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

        focusNode: _focusNodeAbatement,

      );

  }

  Widget footerButtons() {

    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        new RaisedButton(onPressed: (){ _journalingContext.navigateToEntryListView(); }, child: new Text("Back"))

      ],
    );

  }

  Widget divider() {
    return const SizedBox(height: 24.0);
  }


  void loadJournalEntry() {
    _circumstancesController.text = _activeJournalEntry.getCircumstances();
    _descriptionController.text = _activeJournalEntry.getDescription();
    _externalHappeningsController.text = _activeJournalEntry.getExternalHappenings();
    _internalHappeningsController.text = _activeJournalEntry.getInternalHappenings();
    _reflectionsAndCorrectionsController.text = _activeJournalEntry.getReflectionsAndCorrections();
    _abatementController.text = _activeJournalEntry.getAbatement();
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
