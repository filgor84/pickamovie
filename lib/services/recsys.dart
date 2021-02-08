import 'package:pickamovie/models/movie.dart';
import 'package:pickamovie/models/tag.dart';
import 'package:pickamovie/services/db.dart';
import 'package:pickamovie/services/tags_tree_db.dart';

class RecSys {
  Db _db = Db();
  TagsTree _tagsTree = TagsTree();

  Future<List<Tag>> getRecommendedTags(
    List<Tag> tags, {
    int pop = 2,
    int orig = 2,
    int rate = 2,
  }) async {
    List<Tag> relTags = await _tagsTree.getRelevantTags(tags);
    if (relTags.isEmpty) {
      return [];
    } else {
      relTags = await _db.getTagWithMetrics(relTags);
      Set<int> toChose = relTags.map((t) => t.tagId).toList().toSet();
      List<Tag> topPop = new List.from(relTags);
      topPop.sort((Tag t2, Tag t1) =>
          t1.metrics.popularity.compareTo(t2.metrics.popularity));
      List<Tag> topOrig = List.from(relTags);
      topOrig.sort((t1, t2) => t1.metrics.views.compareTo(t2.metrics.views));
      List<Tag> topRate = List.from(relTags);
      topRate.sort((t2, t1) => t1.metrics.rate.compareTo(t2.metrics.rate));
      List<Tag> res = [];
      Tag t = topPop[0];
      while (toChose.isNotEmpty) {
        var i = 0;
        while (i < pop && toChose.isNotEmpty) {
          t = topPop.removeAt(0);
          if (toChose.contains(t.tagId)) {
            toChose.remove(t.tagId);
            res.add(t);
            i++;
          }
        }
        i = 0;
        while (i < rate && toChose.isNotEmpty) {
          t = topRate.removeAt(0);
          if (toChose.contains(t.tagId)) {
            toChose.remove(t.tagId);
            res.add(t);
            i++;
          }
        }
        i = 0;
        while (i < orig && toChose.isNotEmpty) {
          t = topOrig.removeAt(0);
          if (toChose.contains(t.tagId)) {
            toChose.remove(t.tagId);
            res.add(t);
            i++;
          }
        }
      }
      return res;
    }
  }

  Future<List<Movie>> getRecommendedMovies(List<Tag> tags) async {
    return _db.queryMoviesByTags(tags);
  }

  Future<void> updateMetrics(Tag selected, List<Tag> viewed) async {
    num penalty = 0.1;
    num promotion = 1;
    for (Tag tag in viewed) {
      tag.metrics.views += 1;
      tag.metrics.rate += penalty;
    }

    selected.metrics.views += 1;
    selected.metrics.rate += promotion;
    _db.updateMetrics(viewed);
    _db.updateMetrics([selected]);
  }
}
