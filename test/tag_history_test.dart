//import 'dart:html';

import 'package:flutter_test/flutter_test.dart';
//import 'package:pickamovie/models/tag.dart';
//import 'package:test/test.dart';
import 'package:pickamovie/recsys/tag_history.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Save and load', () async {
    var history = TagHistory();
    history.reset();

    Map<String, int> newPrefs = {
      "crime": 5,
      "comedy": 4,
      "romance": 3,
      "fantasy": 5,
    };
    await history.updatePreference(newPrefs);
    print("Update done");
    expect(history.getTagPreference("comedy"), 4);
  });
  test('Single update', () async {
    var history = TagHistory();
    history.reset();

    Map<String, int> newPrefs = {
      "crime": 5,
      "comedy": 4,
      "romance": 3,
      "fantasy": 5,
    };
    await history.updatePreference(newPrefs);
    print("Update done");
    expect(history.getTagPreference("comedy"), 4);
  });
}
