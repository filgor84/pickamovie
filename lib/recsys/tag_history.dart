import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pickamovie/models/tag.dart';

class Preferences {
  Future<Map<String, int>> load() async {
    try {
      final file = await _localFile;
      String jsonData = await file.readAsString();
      return json.decode(jsonData);
    } catch (e) {
      // If encountering an error, return 0.
      return {};
    }
  }

  save(Map <String, int> prefs) async{
    String jsonData = json.encode(prefs);
    final file = await _localFile;
    return file.writeAsString(jsonData);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return await new File('$path/preferences.json').create(recursive: true);
  }
}

class TagHistory {
  Map<String, int> _preferences
  TagHistory(_preferences)

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return await new File('$path/preferences.json').create(recursive: true);
  }

  reset() {
    _preferences = {};
  }

  TagHistory() {
    load();
  }

  load() async {
    final jsonFile = await _localFile;
    jsonFile.readAsString().then((jsonData) {
      _preferences = json.decode(jsonData);
    });
  }

  sortTagByPreferences(List<Tag> tags) {
    tags.sort((t1, t2) => (_preferences[t1.tagName] ?? 0)
        .compareTo(_preferences[t2.tagName] ?? 0));
  }

  getTagPreference(String tagName) {
    return _preferences[tagName] ?? 0;
  }

  save() async {
    String jsonData = json.encode(_preferences);
    _localFile.then((jsonFile) => jsonFile.writeAsString(jsonData));
  }

  updatePreference(Map<String, int> newPrefs) {
    newPrefs.forEach((tag, value) {
      _preferences[tag] = (_preferences[tag] ?? 0) + value;
    });
    this.saveData(_preferences);
  }
}
