
class EmotionContext {

  String _category;
  String _specific;

  Function navigateCategories;
  Function navigateSpecifics;
  Function navigateEmotions;
  Function navigateQuickRate;

  EmotionContext({this.navigateCategories, this.navigateSpecifics, this.navigateEmotions, this.navigateQuickRate});

  String getCategory() {
    return _category;
  }

  void setCategory(String category) {
    this._category = category;
  }

  String getSpecific() {
    return _specific;
  }

  void setSpecific(String specific) {
    this._specific = specific;
  }

  void navigateBackToCategories() {
    Function.apply(navigateCategories, null);
  }

  void setCategoryAndNavigateToSpecifics(String category) {
    _category = category;
    Function.apply(navigateSpecifics, null);
  }

  void navigateBackToSpecifics() {
    Function.apply(navigateSpecifics, null);
  }

  void setSpecificAndNavigateToEmotions(String specifics) {
    _specific = specifics;
    Function.apply(navigateEmotions, null);
  }

  void navigateToQuickRate() {
    Function.apply(navigateQuickRate, null);
  }

}