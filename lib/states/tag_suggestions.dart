import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:pickamovie/models/tag.dart';

class TagSuggestions extends ChangeNotifier {
  Random random;
  List<List<Tag>> windows = [];
  List<Tag> tagsToChose;
  int cur = 0;
  List<Tag> currentWindow;
  TagSuggestions({List<Tag> tagsToChose}) {
    int seed = DateTime.now().millisecondsSinceEpoch;
    this.random = Random(seed);
    this.tagsToChose = tagsToChose;
    List<Tag> sugg = _getNewSuggestions();
    this.windows.add(sugg);
    this.currentWindow = windows[cur];
  }

  bool get isLastWindow => cur == windows.length - 1;
  bool get isFirstWindow => cur == 0;
  bool get isWindowsEnd => isLastWindow && tagsToChose.isEmpty;

  windowFwd() {
    if (!isWindowsEnd) {
      if (isLastWindow) {
        this.windows.add(_getNewSuggestions());
      }
      cur++;
      currentWindow = windows[cur];
      notifyListeners();
    }
  }

  windowBack() {
    if (!isFirstWindow) {
      cur--;
      currentWindow = windows[cur];
    }
    notifyListeners();
  }

  List<Tag> _getTopKFavoriteTags(int k) {
    k = min(k, tagsToChose.length);
    List<Tag> res = tagsToChose.sublist(0, k);
    tagsToChose = tagsToChose.sublist(k);
    return res;
  }

  List<Tag> _getKRandomTags(k) {
    List<Tag> res = [];
    for (int i = 0; i < k; i++) {
      if (tagsToChose.isNotEmpty) {
        int randomId = random.nextInt(tagsToChose.length - 1);
        res.add(tagsToChose.removeAt(randomId));
      }
    }
    return res;
  }

  List<Tag> _getNewSuggestions({int n = 3, int m = 3}) {
    return _getTopKFavoriteTags(n) + _getKRandomTags(m);
  }
}
