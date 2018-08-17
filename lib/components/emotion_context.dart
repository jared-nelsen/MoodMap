
class EmotionContext {

  String _category;
  String _specific;

  Function navigateCategories;
  Function navigateSpecifics;
  Function navigateEmotions;

  EmotionContext(this.navigateCategories, this.navigateSpecifics, this.navigateEmotions);

  String getCategory() {
    return _category;
  }

  String getSpecific() {
    return _specific;
  }

  void navigateBackToCategories() {
    Function.apply(navigateCategories, null);
  }

  void setAndNavigateCategory(String category) {
    _category = category;
    Function.apply(navigateSpecifics, null);
  }

  void setAndNavigateSpecific(String specifics) {
    _specific = specifics;
    Function.apply(navigateEmotions, null);
  }


}