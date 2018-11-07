import 'package:flutter/material.dart';

import 'package:mood_map/login/login_view.dart';
import 'package:mood_map/login/create_account_view.dart';
import 'package:mood_map/login/splash_screen.dart';
import 'package:mood_map/views/view_controller.dart';

class AppViewController extends StatefulWidget {

  @override
  State createState() => new AppViewControllerState();

}

class AppViewControllerState extends State<AppViewController> {

  static PageController _pageController;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(

      body: new PageView(

        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),

        children: <Widget>[

          new SplashScreen(),
          new LoginScreen(),
          new CreateAccountView(),
          new AppShellViewController()

        ],

      ),

    );

  }

  static void navigateToSplashScreen() {
    _navigateToPage(0);
  }

  static void navigateToLoginScreen() {
    _navigateToPage(1);
  }

  static void navigateToCreateAccountView() {
    _navigateToPage(2);
  }

  static void navigateToApplicationShell() {
    _navigateToPage(3);
  }

  static void _navigateToPage(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 1),
        curve: Curves.linear
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

}