import 'package:flutter/material.dart';

import 'package:mood_map/components/ensure_visible_when_focused.dart';

import 'package:mood_map/utilities/session.dart';
import 'package:mood_map/utilities/app_compass.dart';
import 'package:mood_map/utilities/utilities.dart';


class CreateAccountView extends StatefulWidget {

  AppCompass _appCompass;

  CreateAccountView(this._appCompass);

  @override
  State<StatefulWidget> createState() => new CreateAccountViewState(_appCompass);

}

class CreateAccountViewState extends State<CreateAccountView> {

  AppCompass _appCompass;

  final Color backgroundColor1 = new Color(0xFF444152);
  final Color backgroundColor2 = new Color(0xFF6f6c7d);
  final Color highlightColor = new Color(0xfff65aa3);
  final Color foregroundColor = Colors.white;

  final _formKey = new GlobalKey<FormState>();

  FocusNode _emailFocusNode = new FocusNode();
  TextEditingController _emailController = new TextEditingController();
  FocusNode _passwordFocusNode = new FocusNode();
  TextEditingController _passwordController = new TextEditingController();
  FocusNode _repeatPasswordFocusNode = new FocusNode();
  TextEditingController _repeatPasswordController = new TextEditingController();

  CreateAccountViewState(this._appCompass);

  @override
  Widget build(BuildContext context) {


    return new Scaffold(

      body: new SingleChildScrollView(

        child: new Container(

          decoration: new BoxDecoration(

            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
              colors: [this.backgroundColor1, this.backgroundColor2], // whitish to gray
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),

          ),

          height: MediaQuery.of(context).size.height,

          child: new Form(

              key: _formKey,

              child: new Column(
                children: <Widget>[

                  _avatarBlock(),
                  _emailBlock(context),
                  _passwordBlock(context),
                  _repeatPasswordBlock(context),
                  _createAccountButtonBlock(context),

                ],
              ),

          )

        ),

      ),

      resizeToAvoidBottomPadding: false,

    );

  }

  Widget _avatarBlock() {

    return new Container(

      padding: const EdgeInsets.only(top: 70.0, bottom: 30.0),

      child: new Center(

        child: new Column(

          children: <Widget>[

            new Container(
              height: 128.0,
              width: 128.0,
              child: new CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: this.foregroundColor,
                radius: 100.0,
                child: new Text(
                  "MM",
                  style: new TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),

              decoration: new BoxDecoration(
                border: Border.all(
                  color: this.foregroundColor,
                  width: 1.0,
                ),
                shape: BoxShape.circle,
                //image: DecorationImage(image: this.logo)
              ),

            ),

            new Padding(
              padding: const EdgeInsets.all(16.0),
              child: new Text(
                "Mood Map",
                style: new TextStyle(color: this.foregroundColor),
              ),
            )

          ],
        ),
      ),
    );

  }

  Widget _emailBlock(BuildContext context) {

    return new Container(

      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
      alignment: Alignment.center,

      decoration: new BoxDecoration(

        border: new Border(
          bottom: new BorderSide(
              color: this.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),

      ),

      padding: const EdgeInsets.only(left: 0.0, right: 10.0),

      child: new Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[

          new Padding(
            padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
            child: Icon(
              Icons.alternate_email,
              color: this.foregroundColor,
            ),
          ),

          new Expanded(

            child: new EnsureVisibleWhenFocused(

                child: new TextFormField(

                  controller: _emailController,
                  focusNode: _emailFocusNode,

                  textAlign: TextAlign.center,

                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'user@website.com',
                    hintStyle: new TextStyle(color: this.foregroundColor),
                  ),

                  validator: (value) {

                    if(value == null || value.isEmpty) {
                      return "Please enter an email address";
                    }

                  },

                ),

                focusNode: _emailFocusNode,

            )

          ),

        ],

      ),

    );

  }

  Widget _passwordBlock(BuildContext context) {

    return new Container(

      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      alignment: Alignment.center,

      decoration: new BoxDecoration(

        border: new Border(
          bottom: new BorderSide(
              color: this.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),

      ),

      padding: const EdgeInsets.only(left: 0.0, right: 10.0),

      child: new Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[

          new Padding(
            padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
            child: Icon(
              Icons.lock_open,
              color: this.foregroundColor,
            ),
          ),

          new Expanded(

            child: new EnsureVisibleWhenFocused(

                child: new TextFormField(

                  controller: _passwordController,
                  focusNode: _passwordFocusNode,

                  obscureText: true,
                  textAlign: TextAlign.center,

                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: this.foregroundColor),
                  ),

                  validator: (value){

                    if(value == null || value.isEmpty) {
                      return "Please enter a password";
                    }

                  },

                ),

                focusNode: _passwordFocusNode

            )

          ),

        ],

      ),

    );

  }

  Widget _repeatPasswordBlock(BuildContext context) {

    return new Container(

      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
      alignment: Alignment.center,

      decoration: new BoxDecoration(

        border: new Border(
          bottom: new BorderSide(
              color: this.foregroundColor,
              width: 0.5,
              style: BorderStyle.solid),
        ),

      ),

      padding: const EdgeInsets.only(left: 0.0, right: 10.0),

      child: new Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[

          new Padding(
            padding:
            EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
            child: Icon(
              Icons.lock_open,
              color: this.foregroundColor,
            ),
          ),

          new Expanded(

            child: new EnsureVisibleWhenFocused(

                child: new TextFormField(

                  controller: _repeatPasswordController,
                  focusNode: _repeatPasswordFocusNode,

                  obscureText: true,
                  textAlign: TextAlign.center,

                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Repeat Password',
                    hintStyle: TextStyle(color: this.foregroundColor),
                  ),

                  validator: (value) {

                    if(value == null || value.isEmpty) {
                      return "Please repeat the password";
                    }

                  },

                ),

                focusNode: _repeatPasswordFocusNode

            )

          ),

        ],

      ),

    );

  }

  Widget _createAccountButtonBlock(BuildContext context) {

    return new Container(

      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
      alignment: Alignment.center,

      child: new Row(

        children: <Widget>[

          new Expanded(

            child: new FlatButton(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 20.0),
              color: this.highlightColor,

              onPressed: () {

                if(_formKey.currentState.validate()) {

                  if(_passwordController.text != _repeatPasswordController.text) {
                    Utilities.showMessageDialog(context, "Passwords do not match!");
                    return;
                  }

                  if(Session.userAlreadyExists(_emailController.text)){
                    Utilities.showMessageDialog(context, "User already exists").then((Null){_appCompass.navigateToLoginScreen();});
                  }

                  if(Session.login(_emailController.text, _passwordController.text)) {
                    _appCompass.navigateToApplicationShell();
                  } else {
                    Utilities.showMessageDialog(context, "Sucessfully created user but login failed.\nPlease check your network connection.");
                    _appCompass.navigateToLoginScreen();
                  }

                }
                
              },

              child: new Text(
                "Create Account",
                style: new TextStyle(color: this.foregroundColor),
              ),

            ),
          ),

        ],

      ),

    );

  }

}