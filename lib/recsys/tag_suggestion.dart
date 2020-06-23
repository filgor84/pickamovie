import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:pickamovie/models/options.dart';
import 'package:pickamovie/models/tag.dart';

class TagSuggestions {
  List<Tag> _chosenTags = [];
  List<Tag> _availableTags = [];
  Options options;
  var _rng = new Random();

  updateAvailableTags() async {
    final tagNames = _chosenTags.map((e) => e.tagName).toList();
    final fileName = tagNames.join("_") + "tags.json";
    final dirName = "assets/json/";
    await rootBundle.loadString(dirName + fileName).then((String jsonData) {
      Iterable lTags = json.decode(jsonData);
      //print(lTags.toList());
      //List<Map> availableTagsJson = json.decode(jsonData);
      this._availableTags = lTags.map((e) {
        return Tag.fromJson(e);
      }).toList();
      this._availableTags.sort((t1, t2) =>
          t1.suggMovie.popularity.compareTo(t2.suggMovie.popularity));
      //print(_availableTags);
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

  addChosenTag(Tag t) {
    if (_chosenTags.length < 3) {
      _chosenTags.add(t);
      updateAvailableTags();
    } else {
      print("Warning! You can't choose more than 3 tags");
    }
  }

  removeChosenTag(int index) {
    if (_chosenTags.isNotEmpty) {
      _chosenTags.removeAt(index);
      updateAvailableTags();
    } else {
      print("Warning! You can't remove tags from an empty list");
    }
  }

  hasAvailableTags()
  {
    return this._availableTags.isNotEmpty;
  }
}
