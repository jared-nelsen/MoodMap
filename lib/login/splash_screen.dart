import 'package:flutter/material.dart';

import 'package:mood_map/application/app_navigator.dart';

class SplashScreen extends StatefulWidget {

  @override
  State createState() => new SplashScreenState();

}

class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new FlatButton(onPressed: (){ AppNavigator.navigateToLoginScreen(); }, child: new Text("Login Screen")),
          new FlatButton(onPressed: (){ AppNavigator.navigateToCreateAccountView(); }, child: new Text("Create Account")),
          new FlatButton(onPressed: (){ AppNavigator.navigateToApplicationShell(); }, child: new Text("App")),
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