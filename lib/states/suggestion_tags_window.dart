import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:pickamovie/models/tag.dart';

class SuggestionTagsWindow extends ChangeNotifier {
  List<List<Tag>> _suggestionsWindows = [];
  //TagSuggestionsLoader _tagSuggestionsLoader = TagSuggestionsLoader();
  int cur = -1;
  UnmodifiableListView<Tag> get suggestions =>
      UnmodifiableListView(_suggestionsWindows[cur]);
  bool get isLastWindow => cur == _suggestionsWindows.length - 1;
  //final List<Map<String, int>> _newPrefs = [];
  //Preferences _currentPrefs = Preferences();
  addWindow(List<Tag> suggs) {
    _suggestionsWindows.add(suggs);
  }

  resetWindows() {
    _suggestionsWindows.clear();
    notifyListeners();
  }

  windowFwd() {
    cur++;
    notifyListeners();
  }

  windowBack() {
    if (cur > 0) {
      cur--;
    }
    notifyListeners();
  }
}
