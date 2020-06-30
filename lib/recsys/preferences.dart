import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pickamovie/models/tag.dart';

class Preferences {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return await new File('$path/preferences.json').create(recursive: true);
  }

  Future<Map<String, int>> load() async {
    try {
      final file = await _localFile;
      String jsonData = await file.readAsString();
      return json.decode(jsonData);
    } catch (e) {
      return {};
    }
  }

  save(Map<String, int> prefs) async {
    String jsonData = json.encode(prefs);
    final file = await _localFile;
    return file.writeAsString(jsonData);
  }

  sortTagByPreferences(List<Tag> tags) async {
    Map<String, int> preferences = await load();
    tags.sort((t1, t2) =>
        (preferences[t1.tagName] ?? 0).compareTo(preferences[t2.tagName] ?? 0));
  }
}
