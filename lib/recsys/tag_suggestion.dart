import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pickamovie/models/options.dart';
import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/recsys/preferences.dart';

class TagSuggestionsLoader {
  List<Tag> _availableTags = [];
  Options options;
  var _rng = new Random();
  Preferences _pref = Preferences();

  updateAvailableTags(List<Tag> chosenTags) async {
    final tagNames = chosenTags.map((e) => e.tagName).toList();
    tagNames.sort();
    final fileName = tagNames.join("_") + "tags.json";
    final dirName = "assets/json/";
    await rootBundle.loadString(dirName + fileName).then((String jsonData) {
      Iterable lTags = json.decode(jsonData);
      _availableTags = lTags.map((e) {
        return Tag.fromJson(e);
      }).toList();
      _pref.sortTagByPreferences(_availableTags);
    });
  }

  getNTopTags(int n) {
    n = min(n, _availableTags.length);
    List<Tag> nTopTags = _availableTags.sublist(0, n);
    _availableTags = _availableTags.sublist(n);
    return nTopTags;
  }

  getNRandomTags(int n) {
    List<Tag> nRandomTags = [];
    n = min(n, _availableTags.length);
    for (var i = 0; i < n; i++) {
      int max = _availableTags.length;
      int rnd = _rng.nextInt(max);
      nRandomTags.add(_availableTags.removeAt(rnd));
    }
    if (_availableTags.isEmpty) {
      print("Warning! No more available tags!");
    }
    return nRandomTags;
  }

  hasAvailableTags() {
    return this._availableTags.isNotEmpty;
  }
}
