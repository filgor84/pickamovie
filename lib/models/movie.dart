import 'package:flutter/foundation.dart';

class Movie {
  String title;
  String imdbId;
  int popularity;

  Movie({
    @required title,
    @required imdbId,
    @required popularity,
  });

  Movie.fromJson(Map json)
      : title = json["title"],
        imdbId = json["imdbId"],
        popularity = int.parse(json["popularity"]);

  @override
  String toString() {
    return "Title:$title\nImdbId:$imdbId\nPopularity:$popularity\n";
  }
}
