import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pickamovie/models/tag.dart';

class ChosenMovie extends ChangeNotifier {
  final List<Tag> _tags = [];
  UnmodifiableListView<Tag> get tags => UnmodifiableListView(_tags);
  void addTag(Tag t) {
    if (tags.length < 3) {
      _tags.add(t);
      notifyListeners();
    } else {
      print("Warning: trying to search more than 3 tags");
    }
  }

  void removeAll() async {
    _tags.clear();
    notifyListeners();
  }

  void removeAt(int i) {
    _tags.removeAt(i);
    notifyListeners();
  }
}
