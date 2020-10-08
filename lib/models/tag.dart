import 'package:flutter/foundation.dart';
import 'package:pickamovie/models/movie.dart';

class Tag {
  int tagId;
  String tagName;
  Movie suggMovie;

  Tag({
    @required tagId,
    @required tagName,
    @required suggMovie,
  }) {
    this.tagId = tagId;
    this.tagName = tagName;
    this.suggMovie = suggMovie;
  }

  Tag.fromJson(Map json)
      : tagName = json["tag"],
        tagId = json["tagId"],
        suggMovie = Movie.fromJson(json["top_movie"]);
  @override
  String toString() {
    return "Tag: $tagName\nBest Movie:\n" + suggMovie.toString();
  }
}
