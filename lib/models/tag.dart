import 'package:flutter/foundation.dart';
import 'package:pickamovie/models/movie.dart';

class Tag {
  String tagName;
  Movie suggMovie;

  Tag({
    @required tagName,
    @required suggMovie,
  }){
    this.tagName=tagName;
    this.suggMovie=suggMovie;
  }
  
  Tag.fromJson(Map json):
    tagName=json["tag"],
    suggMovie= Movie.fromJson(json["top_movie"]);
  @override
  String toString() {
    return "Tag: $tagName\nBest Movie:\n"+suggMovie.toString();
  }
}
