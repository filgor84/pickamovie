import 'package:pickamovie/models/tag.dart';

class Preferences {
  final Map<String, int> prefs;
  Preferences({this.prefs});

  sortTagByPreferences(List<Tag> tags) {
    tags.sort(
        (t1, t2) => (prefs[t1.tagName] ?? 0).compareTo(prefs[t2.tagName] ?? 0));
  }

  update(Map<String, int> data) {
    data.forEach((key, value) => prefs[key] = (prefs[key] ?? 0) + value);
  }
}
