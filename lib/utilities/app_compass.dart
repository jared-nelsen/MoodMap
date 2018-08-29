
class AppCompass {

  Function _navigateToSplashScreen;
  Function _navigateToLoginScreen;
  Function _navigateToCreateAccountScreen;
  Function _navigateToApplicationShell;

  AppCompass(
      this._navigateToSplashScreen,
      this._navigateToLoginScreen,
      this._navigateToCreateAccountScreen,
      this._navigateToApplicationShell);

  void navigateToSplashScreen() {
    Function.apply(_navigateToSplashScreen, null);
  }

  void navigateToLoginScreen() {
    Function.apply(_navigateToLoginScreen, null);
  }

  void navigateToCreateAccountScreen() {
    Function.apply(_navigateToCreateAccountScreen, null);
  }

  void navigateToApplicationShell() {
    Function.apply(_navigateToApplicationShell, null);
  }

}