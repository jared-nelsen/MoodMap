
import 'package:mood_map/application/app_view_controller.dart';

import 'package:mood_map/views/view_controller.dart';

class AppNavigator {

  //Outer Shell Navigation
  //----------------------------------------------------------------------------

  static void navigateToSplashScreen() {
    AppViewControllerState.navigateToSplashScreen();
  }

  static void navigateToLoginScreen() {
    AppViewControllerState.navigateToLoginScreen();
  }

  static void navigateToCreateAccountView() {
    AppViewControllerState.navigateToCreateAccountView();
  }

  static void navigateToApplicationShell() {
    AppViewControllerState.navigateToApplicationShell();
  }


  //App Navigation
  //----------------------------------------------------------------------------
  static void navigateToMakeJournalView() {
    AppShellViewControllerState.navigateToJournalView();
  }

}