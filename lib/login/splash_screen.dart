import 'package:flutter/material.dart';

import 'package:mood_map/utilities/app_compass.dart';

class SplashScreen extends StatefulWidget {

  final AppCompass _appCompass;

  SplashScreen(this._appCompass);

  @override
  State createState() => new SplashScreenState(_appCompass);

}

class SplashScreenState extends State<SplashScreen> {

  AppCompass _appCompass;

  SplashScreenState(this._appCompass);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new FlatButton(onPressed: (){ _appCompass.navigateToLoginScreen(); }, child: new Text("Login Screen")),
          new FlatButton(onPressed: (){ _appCompass.navigateToCreateAccountScreen(); }, child: new Text("Create Account")),
          new FlatButton(onPressed: (){ _appCompass.navigateToApplicationShell(); }, child: new Text("App")),
        ],
      )
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

}