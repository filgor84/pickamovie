import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PreferencesDb {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return await new File('$path/preferences.json').create(recursive: true);
  }

  Future<Map<String, int>> get prefs async {
    try {
      final file = await _localFile;
      String jsonData = await file.readAsString();
      return json.decode(jsonData);
    } catch (e) {
      print(e);
      return null;
    }
  }

  save(Map<String, int> prefs) async {
    try {
      String jsonData = json.encode(prefs);
      final file = await _localFile;
      return file.writeAsString(jsonData);
    } catch (e) {
      print(e);
      return null;
    }
  }

  reset() async {
    this.save({});
  }
}
