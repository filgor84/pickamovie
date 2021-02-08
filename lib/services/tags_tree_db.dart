import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pickamovie/models/tag.dart';

class TagsTree {
  //Db _db = Db();
  Future<List<Tag>> getRelevantTags(List<Tag> chosenTags) async {
    final tagNames = chosenTags.map((e) => e.tagName).toList();
    tagNames.sort();
    final fileName = (tagNames + ["tags.json"]).join("_");
    final dirName = "assets/json/";
    final String path = dirName + fileName.replaceAll(" ", "");
    try {
      String jsonData = await rootBundle.loadString(path);
      Iterable lTags = json.decode(jsonData);
      List<Tag> tags = lTags.map((e) => Tag.fromJson(e)).toList();

      /*List<Map> tagsMetrics = await _db.getTagMetrics(tags.map((e) => e.tagId));
      Map metrics = Map();
      for (Map row in tagsMetrics) {
        metrics[row["tagId"]] = row;
      }
      for (Tag tag in tags) {
        if (metrics.containsKey(tag.tagId)) {
          tag.metrics.views = metrics[tag.tagId]["views"] ?? 0;
          tag.metrics.rate = metrics[tag.tagId]["rate"] ?? 0;
        }
      }*/
      return tags;
    } catch (_) {
      return [];
    }
  }
}
