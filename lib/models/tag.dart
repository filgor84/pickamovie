import 'package:flutter/foundation.dart';
import 'package:pickamovie/models/metrics.dart';
import 'package:pickamovie/models/movie.dart';

class Tag {
  int tagId;
  String tagName;
  Movie suggMovie;
  Metrics metrics;

  Tag({
    @required tagId,
    @required tagName,
    @required suggMovie,
    @required metrics,
  }) {
    this.tagId = tagId;
    this.tagName = tagName;
    this.suggMovie = suggMovie;
    this.metrics = metrics;
  }

  Tag.fromJson(Map json)
      : tagName = json["tag"],
        tagId = json["tagId"],
        suggMovie = Movie.fromJson(json["top_movie"]),
        metrics = Metrics(pop: json["tag_popularity"]);
  @override
  String toString() {
    return "Tag: $tagName\nBest Movie:\n" + suggMovie.toString();
  }

  @override
  bool operator ==(other) => other is Tag && (other.tagId == tagId);

  @override
  int get hashCode => tagId;
}
