
class EmotionContext {

  String _category;
  String _specific;

  Function _navigateCategories;
  Function _navigateSpecifics;
  Function _navigateEmotions;

  EmotionContext(this._navigateCategories, this._navigateSpecifics, this._navigateEmotions);

  String getCategory() {
    return _category;
  }

  String getSpecific() {
    return _specific;
  }

  void navigateBackToCategories() {
    Function.apply(_navigateCategories, null);
  }

  void setCategoryAndNavigateToSpecifics(String category) {
    _category = category;
    Function.apply(_navigateSpecifics, null);
  }

  void navigateBackToSpecifics() {
    Function.apply(_navigateSpecifics, null);
  }

  void setSpecificAndNavigateToEmotions(String specifics) {
    _specific = specifics;
    Function.apply(_navigateEmotions, null);
  }


}