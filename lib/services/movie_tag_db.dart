import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pickamovie/models/movie.dart';
import 'package:pickamovie/models/tag.dart';

class MovieTagDb {
  Future<List<Tag>> getRelevantTags(List<Tag> chosenTags) async {
    final tagNames = chosenTags.map((e) => e.tagName).toList();
    tagNames.sort();
    final fileName = (tagNames + ["tags.json"]).join("_");
    final dirName = "assets/json/";
    final String path = dirName + fileName;
    try {
      String jsonData = await rootBundle.loadString(path);
      Iterable lTags = json.decode(jsonData);
      return lTags.map((e) => Tag.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<Movie>> getTopPopularMovie(List<Tag> chosenTags) async {
    return [];
  }
}
