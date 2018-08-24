
class AppCompass {

  Function _navigateToSplashScreen;
  Function _navigateToLoginScreen;
  Function _navigateToCreateAccountView;
  Function _navigateToApplicationShell;

  AppCompass(
      this._navigateToSplashScreen,
      this._navigateToLoginScreen,
      this._navigateToCreateAccountView,
      this._navigateToApplicationShell);

  void navigateToSplashScreen() {
    Function.apply(_navigateToSplashScreen, null);
  }

  void navigateToLoginScreen() {
    Function.apply(_navigateToLoginScreen, null);
  }

  void navigateToCreateAccountView() {
    Function.apply(_navigateToCreateAccountView, null);
  }

  void navigateToApplicationShell() {
    Function.apply(_navigateToApplicationShell, null);
  }

}